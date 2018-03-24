class Custodian < ApplicationRecord
  belongs_to :employee
  belongs_to :custodian_account
  has_many :software
  has_many :hardware
end
