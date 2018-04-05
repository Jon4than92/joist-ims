class Custodian < ApplicationRecord
  belongs_to :employee
  belongs_to :custodian_account
  has_many :software
  has_many :hardware

  validates :custodian_account_id, presence: true

  before_validation do
    self.employee_id = self.employee.id
  end
end
