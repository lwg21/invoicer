class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.string :date
      t.boolean :issued, default: false, null: false
      t.references :client, null: false, foreign_key: true
      t.timestamps
    end
  end
end
