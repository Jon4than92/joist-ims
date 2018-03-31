class Employee < ApplicationRecord
  belongs_to :room
  has_one :account
  has_many :custodians
  has_many :custodian_accounts, through: :custodians
  has_many :hardware
  has_many :software

  accepts_nested_attributes_for :account

  def full_name
    first_name + ' ' + (middle_initial ? middle_initial + ' ' : '') + last_name
  end
end
