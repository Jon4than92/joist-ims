class Employee < ApplicationRecord
  belongs_to :location
  has_one :account
  has_many :custodians
  has_many :custodian_accounts, through: :custodians
  has_many :hardware
  has_many :software

  def full_name
    first_name + ' ' + (middle_initial ? middle_initial + ' ' : '') + last_name
  end

  def building
    location.building
  end

  def room
    location.room
  end
end
