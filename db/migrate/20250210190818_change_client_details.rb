class ChangeClientDetails < ActiveRecord::Migration[8.0]
  def change
    # Clients table
    add_column :clients, :name, :string
    rename_column :clients, :designation, :details

    # Backup data
    Client.all.each do |client|
      details = [
        client.details,
        client.address_line1,
        client.address_line2,
        client.city,
        client.postal_code,
        client.country
      ]

      client.update(
        name: client.details.split("\n").first,
        details: details.join("\n")
      )
    end

    remove_column :clients, :address_line1, :string
    remove_column :clients, :address_line2, :string
    remove_column :clients, :city, :string
    remove_column :clients, :postal_code, :string
    remove_column :clients, :country, :string

    # Invoice tables
    rename_column :invoices, :client_designation, :client_details

    remove_column :invoices, :client_address_line1, :string
    remove_column :invoices, :client_address_line2, :string
    remove_column :invoices, :client_city, :string
    remove_column :invoices, :client_postal_code, :string
    remove_column :invoices, :client_country, :string
  end
end
