class CustodianAccount < ApplicationRecord
  has_many :custodians
  has_many :employees, through: :custodians
end
