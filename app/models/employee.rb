class Employee < ApplicationRecord
  belongs_to :room
  has_one :account, inverse_of: :employee
  has_many :custodians, inverse_of: :employee
  has_many :custodian_accounts, through: :custodians
  has_many :assigned_hardware, class_name: 'Hardware', foreign_key: :assigned_to_id
  has_many :updated_hardware, class_name: 'Hardware', foreign_key: :updated_by_id
  has_many :created_hardware, class_name: 'Hardware', foreign_key: :created_by_id
  has_many :software

  accepts_nested_attributes_for :room
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :custodians, allow_destroy: true

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z -]+\z/i, message: 'cannot contain numbers or symbols' }
  validates :middle_initial, format: { with: /\A[a-zA-Z -]+\z/i, message: 'cannot contain numbers or symbols' }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z -.]+\z/i, message: 'cannot contain numbers or symbols' }
  validates :job_title, presence: true
  validates :room_id, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'must be formatted as email@domain.com' }
  validates :phone, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, message: 'must be formatted as ###-###-####' }

  def full_name
    first_name + ' ' + (middle_initial ? middle_initial + ' ' : '') + last_name
  end
end
