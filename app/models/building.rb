class Building < ApplicationRecord
  has_many :rooms
  belongs_to :created_by, class_name: 'Employee', optional: true
  belongs_to :updated_by, class_name: 'Employee', optional: true

  accepts_nested_attributes_for :rooms

  validates :name, presence: true
end
