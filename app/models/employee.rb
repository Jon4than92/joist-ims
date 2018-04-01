class Employee < ApplicationRecord
  belongs_to :room
  has_one :account
  has_many :custodians
  has_many :custodian_accounts, through: :custodians
  has_many :hardware
  has_many :software

  accepts_nested_attributes_for :account

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :job_title, :presence => true
  validates :room_id, :presence => true
  validates :email, :presence => true
  validates :phone, :presence => true

  def full_name
    first_name + ' ' + (middle_initial ? middle_initial + ' ' : '') + last_name
  end
end
