class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :employee
  belongs_to :account_type

  before_validation do
    self.email = self.employee.email
  end
end
