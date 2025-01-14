class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :designation
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :vat_number
      t.string :phone_number
      t.string :email_address
      t.string :iban
      t.string :bic
      t.string :jurisdiction
      t.integer :next_available_number, default: 0, null: false

      t.timestamps
    end
  end
end
