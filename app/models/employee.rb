class Employee < ApplicationRecord
  belongs_to :location
  has_one :account
  has_many :custodians
  has_many :custodian_accounts, through: :custodians
  has_many :hardware
  has_many :software
end
