class Company < ApplicationRecord
  belongs_to :user
  has_many :invoices
  has_many :mention_defaults
end
