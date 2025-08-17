class Mention < ApplicationRecord
  belongs_to :invoice
  validates :text, presence: true
end
