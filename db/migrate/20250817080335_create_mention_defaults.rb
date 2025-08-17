class CreateMentionDefaults < ActiveRecord::Migration[8.0]
  def change
    create_table :mention_defaults do |t|
      t.string :text
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
