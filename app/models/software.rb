class Software < ApplicationRecord
  belongs_to :vendor
  belongs_to :hardware, optional: true
  belongs_to :assigned_to, class_name: 'Employee', optional: true
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true
  belongs_to :custodian, optional: true

  validates :name, presence: true
  validates :vendor_id, presence: true
  validates :version, presence: true
  validates :year, presence: true, format: { with: /\A\d{4}\z/, message: 'must contain only four digits' }

  before_validation :check_license_dates
  before_validation :check_both_dates_set
  before_validation :check_assigned_hardware
  before_validation :set_assigned_date
  before_validation :check_license_end_not_passed
  before_save :calc_time_remaining
  before_save :set_expiration_status

  def set_expiration_status
    if self.license_end_date?
      if self.license_end_date <= Date.today
        status_tag = 'License Expired'
      elsif self.license_end_date <= Date.today + 1.month and self.active = true
        status_tag = 'Renewal Urgent'
      elsif self.license_end_date > Date.today + 1.month and self.license_end_date < Date.today + 3.months and self.active = true
        status_tag = 'Expiring Soon'
      else self.license_end_date > Date.today + 3.months and self.active = true
        status_tag = 'License Valid'
      end
    end
  end

  def calc_time_remaining
    time_remaining = (self.license_end_date - Date.today).to_i if self.license_end_date?
  end

  private
    def check_license_dates
      if self.license_start_date? and self.license_end_date?
        if self.license_end_date < self.license_start_date
          errors.add(:license_end_date, 'must be after license start date')
        end
      end
    end

    def set_assigned_date
      if self.assigned_to_id?
        self.assigned_date = Date.today
      else
        self.assigned_date = nil
      end
    end

    def check_assigned_hardware
      if self.license_start_date? and self.license_end_date?
        if self.active == false
          errors.add(:base, 'Software must be marked as active if entering license start and end dates')
        end
      end
    end

    def check_both_dates_set
      if (self.license_start_date? and not self.license_end_date?) or (not self.license_start_date? and self.license_end_date?)
        errors.add(:base, 'License start date and end date must be set at the same time')
      end
    end

    def check_license_end_not_passed
      if self.license_end_date < Date.today
        errors.add(:license_end_date, 'must be in the future')
      end
    end

end
