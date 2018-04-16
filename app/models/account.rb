class Account < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  belongs_to :employee, inverse_of: :account
  belongs_to :account_type

  accepts_nested_attributes_for :account_type

  validates :account_type_id, presence: true

  before_validation do
    if self.new_record?
      self.email = self.employee.email
      self.password = 'password'
      self.password_confirmation = 'password'
    end
  end
end
