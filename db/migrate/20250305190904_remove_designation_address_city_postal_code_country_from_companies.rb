class RemoveDesignationAddressCityPostalCodeCountryFromCompanies < ActiveRecord::Migration[8.0]
  def change
    remove_column :companies, :designation, :string
    remove_column :companies, :address_line1, :string
    remove_column :companies, :address_line2, :string
    remove_column :companies, :city, :string
    remove_column :companies, :postal_code, :string
    remove_column :companies, :country, :string

    remove_column :invoices, :company_designation, :string
    remove_column :invoices, :company_address_line1, :string
    remove_column :invoices, :company_address_line2, :string
    remove_column :invoices, :company_city, :string
    remove_column :invoices, :company_postal_code, :string
    remove_column :invoices, :company_country, :string
  end
end
