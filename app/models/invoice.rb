class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items

  def total
    self.invoice_items.sum { |item| item.total_price }
  end
end
