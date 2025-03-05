class AddDetailsToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :details, :string
    add_column :invoices, :company_details, :string
  end
end
