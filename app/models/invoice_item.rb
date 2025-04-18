class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  before_create :set_position, unless: :position
  after_destroy -> { invoice.reorder_items! }

  def total_price
    (self.unit_price || 0) * (self.quantity || 0)
  end

  def set_position
    max_position = invoice.invoice_items.maximum(:position)
    self.position = max_position ? max_position + 1 : 1
  end
end
