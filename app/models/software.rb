class Software < ApplicationRecord
  belongs_to :vendor
  belongs_to :hardware
  belongs_to :employee
  belongs_to :custodian

  validates :name, presence: true
  validates :vendor_id, presence: true
  validates :version, presence: true
  validates :year, presence: true, format: { with: /\A\d{4}\z/, message: 'must contain only four digits' }
  validates :license_start_date, presence: true
  validates :license_end_date, presence: true

  before_save :calc_time_remaining
  before_validation :check_license_dates
  before_validation :set_assigned_date
  before_save :set_expiration_status

 # before_save :status_tag_for_license
#  validates :status_tag, presence: true
#  validates :set_expiration_status, presence: true
#  validates :set_expiration_status, :inclusion => { :in => ['Renew Now', 'Expiring Soon', 'License Valid'] }

  def set_expiration_status
    if (self.active == false)
      status_tag = 'License Expired'
    elsif (self.license_end_date <= Date.today + 1.month && self.active = true)
      status_tag = 'Renewal Urgent'
    elsif (self.license_end_date > Date.today + 1.month && self.license_end_date < Date.today + 3.months && self.active = true)
      status_tag = 'Expiring Soon'
   #   status_tag = 'Expiring in ' + "#{self.calc_time_remaining} days"
    else (self.license_end_date > Date.today + 3.months && self.active = true)
      status_tag = 'License Valid'
    end
  end

    def calc_time_remaining
      end_date = self.license_end_date
      date_now = Date.today()
      time_remaining = (end_date - date_now).to_i
    end

  private
    def check_license_dates
      if self.license_start_date.blank? and self.license_end_date.blank?
        if self.license_end_date < self.license_start_date
          errors.add(:license_end_date, 'Must be after license start date')
        end
      end
    end


    def set_assigned_date
      if self.employee_id?
        self.assigned_date = Date.today
      else
        self.assigned_date = nil
      end
    end

# BROKEN CASE SWITCH // GHETTO FIXED WITH CSS ON STATUS TAGS - SEE MODEL FOR STATUS_TAG FUNCTIONALITY
#
#  def status_tag_for_license(software)
#    printonrails_status_tag software_set_expiration_status(software), color_for_weight(software.set_expiration_status)
#  end

#  def color_for_weight(weight)
#    case weight
#      when 'Renew Now'
#        :red
#      when 'Expiring Soon'
#        :yellow
#      when 'License Valid'
#        :green
#    end
#  end

end
