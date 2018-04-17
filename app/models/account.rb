class Account < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable

  belongs_to :employee, inverse_of: :account
  belongs_to :account_type

  attr_accessor :new_password
  attr_accessor :new_password_confirmation

  accepts_nested_attributes_for :account_type

  validates :account_type_id, presence: true

  before_validation :set_credentials
  before_validation :change_password

  #=============================
  @default_password = 'password'
  #=============================

  def set_credentials
    if self.new_record?
      self.email = self.employee.email
      self.password = @default_password
      self.password_confirmation = @default_password
    end
  end

  def change_password
    if !self.new_password.blank? and !self.new_password_confirmation.blank?
      if self.new_password == self.new_password_confirmation
        if self.password == self.new_password
          self.errors.add(:base, 'New password cannot be the same as your old password')
        elsif self.new_password !~ /.{8,}/
          self.errors.add(:base, 'New password must contain at least 8 characters')
        elsif self.new_password !~ /[a-z]/
          self.errors.add(:base, 'New password must contain a lowercase letter')
        elsif self.new_password !~ /[A-Z]/
          self.errors.add(:base, 'New password must contain an uppercase letter')
        elsif self.new_password !~ /[!@#$%^&*()_\\\-+=<,>.?\/:;\[{}\]''""|]/
          self.errors.add(:base, 'New password must contain a symbol')
        else
          self.password = self.new_password
          self.password_confirmation = self.new_password_confirmation
        end
      else
        self.errors.add(:base, 'New password was not retyped correctly')
      end
    end
  end

  def reset_password
    self.password = @default_password
    self.password_confirmation = @default_password
  end
end
