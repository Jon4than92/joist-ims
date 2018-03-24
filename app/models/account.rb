class Account < ApplicationRecord
  belongs_to :employee
  belongs_to :account_type
end
