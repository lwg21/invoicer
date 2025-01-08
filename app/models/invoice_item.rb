class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  def total_price
    self.unit_price * self.quantity
  end
end
