class Room < ApplicationRecord
  belongs_to :building
  has_many :employees
  has_many :hardware

  validates :name, presence: true
end
