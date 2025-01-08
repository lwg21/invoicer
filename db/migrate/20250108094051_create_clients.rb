class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :designation
      t.string :address
      t.string :vat_number
      t.string :phone_number
      t.string :email_address
      t.timestamps
    end
  end
end
