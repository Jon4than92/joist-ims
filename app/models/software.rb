class Software < ApplicationRecord
  belongs_to :vendor
  belongs_to :hardware
  belongs_to :assigned_to, class_name: 'Employee'
  belongs_to :custodian

  validates :name, presence: true
  validates :vendor_id, presence: true
  validates :version, presence: true
  validates :year, presence: true, format: { with: /\A\d{4}\z/, message: 'must contain only four digits' }
  validates :hardware_id, presence: true
  validates :license_start_date, :license_end_date, presence: true
  before_save :license_date_valid
  before_save :set_expiration_status
#  validates :status_tag, presence: true
#  validates :set_expiration_status, presence: true

  def set_expiration_status
    if (license_end_date >= Date.today + 1.month)
      status_tag = 'Renew Now!'
    elsif (license_end_date < Date.today() + 1.month && license_end_date >= Date.today() + 3.months)
      status_tag = 'Expiring Soon'
    else (license_end_date < Date.today() + 3.months)
      status_tag = 'License Valid'
    end
  end

  private
    def license_date_valid
      return if :license_start_date.blank? || :license_end_date.blank?

        if (license_start_date > license_end_date)
          errors.add(:license_end_date, "Must be after License Start Date")
        end
    end

#  def status_tag_for_license(software)
#    printonrails_status_tag software_license_end_date(software), color_for_weight(software.license_end_date)
#  end

#  def color_for_weight(weight)
#    case weight
#     when :license_end_date <= 1.month.from_now
#        :red
#      when :license_end_date <= Date.today() && :license_end_date > 3.months.from_now
#        :yellow
#     when :license_end_date >= Date.today() + 3.months.from_now
#        :green
#    end
#  end

end
