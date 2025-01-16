class Invoice < ApplicationRecord
  belongs_to :client
  belongs_to :company
  has_many :invoice_items, dependent: :destroy

  SNAPSHOT_REFS = {
    client: [
      "designation",
      "address_line1",
      "address_line2",
      "city",
      "postal_code",
      "country",
      "vat_number"
    ],
    company: [
      "designation",
      "address_line1",
      "address_line2",
      "city",
      "postal_code",
      "country",
      "vat_number",
      "phone_number",
      "email_address",
      "iban",
      "bic",
      "jurisdiction"
    ]
  }

  # Reader methods for snapshotted columns
  SNAPSHOT_REFS.each do |table, columns|
    columns.each do |column|
      define_method("display_#{table}_#{column}") do
        issued? ? public_send("#{table}_#{column}") : public_send(table).public_send(column)
      end
    end
  end

  def total
    self.invoice_items.sum { |item| item.total_price }
  end

  def issue!
    self.update(issued: true)
    self.assign_number!
    self.assign_date!
    self.snapshot_data!
  end

  # TEMP DEBUG
  def unissue!
    self.update(issued: false)
    self.update(number: nil, date: nil)
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

  # Snapshot data from associated tables upon issuance of invoice
  def snapshot_data!
    snapshot_data = {}
    SNAPSHOT_REFS.each do |table, columns|
      columns.each do |column|
        snapshot_data["#{table}_#{column}"] = public_send(table).public_send(column)
      end
    end
    self.update(snapshot_data)
  end
end
