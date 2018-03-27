class Building < ApplicationRecord
  has_many :locations
  has_many :rooms, through: :locations

  accepts_nested_attributes_for :locations
end
