class Building < ApplicationRecord
  has_many :locations
  has_many :rooms, through: :locations
end
