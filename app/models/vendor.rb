class Vendor < ApplicationRecord
  has_many :software

  validates :name, presence: true
end
