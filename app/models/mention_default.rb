class MentionDefault < ApplicationRecord
  belongs_to :company
  validates :text, presence: true
end
