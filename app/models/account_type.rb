class AccountType < ApplicationRecord
  has_many :accounts

  validates :name, uniqueness: true, presence: true
end
