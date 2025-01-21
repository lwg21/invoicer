class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.integer :number
      t.date :date
      t.boolean :issued, default: false, null: false
      t.boolean :paid, default: false, null: false
      t.references :client, null: false, foreign_key: true
      t.timestamps
    end
  end
end
