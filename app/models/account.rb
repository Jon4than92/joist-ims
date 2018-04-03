class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :employee, inverse_of: :account
  belongs_to :account_type

  accepts_nested_attributes_for :account_type

  before_validation do
    if self.new_record?
      self.email = self.employee.email
      self.password = 'password'
      self.password_confirmation = 'password'
    end
  end

  before_save do
    #if self.account_type_id == 1
    #  Custodian.create!(employee_id: self.employee_id, custodian_account_id: 1)
    #end
  end
end
