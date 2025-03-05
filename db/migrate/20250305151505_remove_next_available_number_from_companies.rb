class RemoveNextAvailableNumberFromCompanies < ActiveRecord::Migration[8.0]
  def change
    remove_column :companies, :next_available_number, :integer
  end
end
