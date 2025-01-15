class CreateInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.date :date
      t.integer :quantity # , null: false, default: 1
      t.decimal :unit_price # , precision: 10, scale: 2, null: false
      # t.decimal :total_price # , precision: 10, scale: 2, null: false
      # t.date :accounting_date
      t.integer :position
      t.timestamps
    end
  end
end
