class CreateInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice
      t.string :name
      t.string :description
      t.date :date
      t.integer :quantity # , null: false, default: 1
      t.decimal :unit_price # , precision: 10, scale: 2, null: false
      # t.decimal :total_price # , precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
