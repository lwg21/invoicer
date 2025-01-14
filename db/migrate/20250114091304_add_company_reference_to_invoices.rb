class AddCompanyReferenceToInvoices < ActiveRecord::Migration[8.0]
  def change
    add_reference :invoices, :company, null: false, foreign_key: true
  end
end
