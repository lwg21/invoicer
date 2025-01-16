class CreateMentions < ActiveRecord::Migration[8.0]
  def change
    create_table :mentions do |t|
      t.references :invoice, null: false, foreign_key: true
      t.integer :position
      t.string :text

      t.timestamps
    end
  end
end
