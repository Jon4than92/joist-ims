class Hardware < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :room
  belongs_to :assigned_to, class_name: 'Employee'
  belongs_to :custodian
  has_many :software

  validates :name, presence: true
  validates :manufacturer_id, presence: true
  validates :year, presence: true, format: { with: /\A\d{4}\z/, message: 'must contain only four digits' }
  validates :model_num, presence: true
  validates :tag_num, presence: true
  validates :serial_num, presence: true
  validates :cost, presence: true
  validates :condition, presence: true
  validates :room_id, presence: true

  before_validation do
    if self.year > Date.today().year
      self.errors.add(:year, 'cannot be greater than ' + Date.today().year)
    elsif self.year < 1900
      self.errors.add(:year, 'cannot be less than 1900')
    end
  end
end
