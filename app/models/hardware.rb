class Hardware < ApplicationRecord
  belongs_to :manufacturer
  accepts_nested_attributes_for :manufacturer
  belongs_to :room
  belongs_to :employee
  belongs_to :custodian
  has_many :software
end
