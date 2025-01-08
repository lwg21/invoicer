class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  def total_price
    (self.unit_price || 0) * (self.quantity || 0)
  end
end
