class Software < ApplicationRecord
  belongs_to :vendor
  belongs_to :employee
  belongs_to :hardware
  belongs_to :custodian

  validates :name, presence: true
  validates :vendor_id, presence: true
  validates :version, presence: true
  validates :year, presence: true, format: { with: /\A\d{4}\z/, message: 'must contain only four digits' }
  validates :hardware_id, presence: true
end
