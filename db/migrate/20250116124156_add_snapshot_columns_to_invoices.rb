class AddSnapshotColumnsToInvoices < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :client_designation, :string
    add_column :invoices, :client_address_line1, :string
    add_column :invoices, :client_address_line2, :string
    add_column :invoices, :client_city, :string
    add_column :invoices, :client_postal_code, :string
    add_column :invoices, :client_country, :string
    add_column :invoices, :client_vat_number, :string

    add_column :invoices, :company_designation, :string
    add_column :invoices, :company_address_line1, :string
    add_column :invoices, :company_address_line2, :string
    add_column :invoices, :company_city, :string
    add_column :invoices, :company_postal_code, :string
    add_column :invoices, :company_country, :string
    add_column :invoices, :company_vat_number, :string
    add_column :invoices, :company_phone_number, :string
    add_column :invoices, :company_email_address, :string
    add_column :invoices, :company_iban, :string
    add_column :invoices, :company_bic, :string
    add_column :invoices, :company_jurisdiction, :string
  end
end
