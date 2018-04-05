class Manufacturer < ApplicationRecord
  has_many :hardware

  validates :name, presence: true
end
