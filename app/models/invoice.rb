class Invoice < ApplicationRecord
  belongs_to :client
  belongs_to :company
  has_many :invoice_items

  def total
    self.invoice_items.sum { |item| item.total_price }
  end

  def issue!
    self.update(issued: true)
  end
end
