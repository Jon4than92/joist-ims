class Manufacturer < ApplicationRecord
  has_many :hardware
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
