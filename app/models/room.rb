class Room < ApplicationRecord
  belongs_to :building
  has_many :employees
  has_many :hardware

  accepts_nested_attributes_for :employees
end
