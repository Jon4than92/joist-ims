class Software < ApplicationRecord
  belongs_to :vendor
  belongs_to :employee
  belongs_to :hardware
  belongs_to :custodian
end
