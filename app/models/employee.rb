class Employee < ApplicationRecord
  belongs_to :room
  has_one :account, inverse_of: :employee
  has_many :custodians, inverse_of: :employee
  has_many :custodian_accounts, through: :custodians
  has_many :hardware
  has_many :software

  accepts_nested_attributes_for :room
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :custodians, allow_destroy: true

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z -]+\z/i, message: 'cannot contain numbers or symbols' }
  validates :middle_initial, format: { with: /\A[a-zA-Z -]+\z/i, message: 'cannot contain numbers or symbols' }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z -.]+\z/i, message: 'cannot contain numbers or symbols' }
  validates :job_title, presence: true
  validates :room_id, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'must follow the "example@email.com" format' }
  validates :phone, presence: true, format: { with: /\A^\d{3}-\d{3}-\d{4}$\z/i, message: 'Must be formatted as: ###-###-####' }

  def full_name
    first_name + ' ' + (middle_initial ? middle_initial + ' ' : '') + last_name
  end
end
