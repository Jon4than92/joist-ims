class Building < ApplicationRecord
  has_many :rooms

  accepts_nested_attributes_for :rooms

  validates :name, presence: true
end
