class CreateInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.date :date
      t.integer :quantity
      t.decimal :unit_price
      t.integer :position
      t.timestamps
    end
  end
end
