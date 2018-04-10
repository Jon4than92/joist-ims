class Room < ApplicationRecord
  belongs_to :building
  has_many :employees
  has_many :hardware
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true

  validates :name, presence: true
end
