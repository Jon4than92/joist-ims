class Vendor < ApplicationRecord
  has_many :software
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true

  validates :name, presence: true
end
