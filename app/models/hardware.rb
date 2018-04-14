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
  validates :tag_num, uniqueness: { case_sensitive: false }, presence: true
  validates :serial_num, uniqueness: { case_sensitive: false }, presence: true
  #validates_numericality_of  :cost, presence: true, only_integer: true
  validates :condition, presence: true
  validates :room_id, presence: true

  before_validation :check_year
  before_validation :check_cost
  before_validation :set_assigned_date

  private
    def check_year
      if self.year > Date.today.year
        self.errors.add(:year, 'cannot be greater than ' + Date.today.year)
      elsif self.year < 0
        self.errors.add(:year, 'cannot be negative')
      end
    end

    def check_cost
      if self.cost.is_a? Numeric
        if self.cost < 0
          self.errors.add(:cost, 'cannot be negative')
        end
      else
        self.errors.add(:cost, 'must be a numeric value. Strings/symbols not permitted')
      end
    end

    def set_assigned_date
      if self.assigned_to_id?
        self.assigned_date = Date.today
      else
        self.assigned_date = nil
      end
    end
end
