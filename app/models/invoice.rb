class Invoice < ApplicationRecord
  belongs_to :client
  belongs_to :company
  has_many :invoice_items, dependent: :destroy

  def total
    self.invoice_items.sum { |item| item.total_price }
  end

  def issue!
    self.update(issued: true)
    self.assign_number!
    self.assign_date!
  end

  def assign_number!
    last_number = self.company.invoices.maximum(:number) || 0
    self.update(number: last_number + 1)
  end

  def assign_date!
    self.update(date: Date.today)
  end

  def reorder_items!
    invoice_items.order(position: :asc).each_with_index do |item, index|
      item.update(position: index + 1)
    end
  end
end
