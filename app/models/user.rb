class User < ApplicationRecord
  # Authentication
  has_secure_password
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_one :company, dependent: :destroy
  after_create -> { self.create_company }
end
