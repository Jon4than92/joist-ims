class Custodian < ApplicationRecord
  belongs_to :employee
  belongs_to :custodian_account
  has_many :software
  has_many :hardware

  validates :employee_id, :presence => true
  validates :custodian_account_id, :presence => true

  before_validation do
    self.employee_id = self.employee.id
  end
end
