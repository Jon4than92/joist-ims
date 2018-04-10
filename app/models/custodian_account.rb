class CustodianAccount < ApplicationRecord
  has_many :custodians
  has_many :employees, through: :custodians
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true
end
