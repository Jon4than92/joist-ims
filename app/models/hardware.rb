class Hardware < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :room
  belongs_to :assigned_to, class_name: 'Employee', optional: true
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true
  belongs_to :custodian, optional: true
  has_many :software

  validates :name, presence: true
  validates :manufacturer_id, presence: true
  validates :year, presence: true, format: { with: /\A\d{4}\z/, message: 'must contain four digits' }
  validates :model_num, presence: true
  validates :tag_num, presence: true
  validates :serial_num, presence: true
  validates :cost, presence: true
  validates :condition, presence: true
  validates :room_id, presence: true

  before_validation :check_year
  before_validation :set_assigned_date
  #before_validation :set_created_by
  #before_validation :set_updated_by

  private
    def check_year
      if self.year > Date.today.year
        self.errors.add(:year, 'cannot be greater than ' + Date.today.year)
      elsif self.year < 1900
        self.errors.add(:year, 'cannot be less than 1900')
      end
    end

    def set_assigned_date
      if self.assigned_to_id?
        self.assigned_date = Date.today
      else
        self.assigned_date = nil
      end
    end

    def set_created_by
      self.created_by = current_account.id if self.new_record? and self.created_by == nil
    end

    def set_updated_by
      self.updated_by = current_account.id if !self.new_record?
    end
end
