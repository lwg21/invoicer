class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.string :date
      t.references :client
      t.timestamps
    end
  end
end
