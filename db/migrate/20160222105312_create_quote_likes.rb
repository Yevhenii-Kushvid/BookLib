class CreateQuoteLikes < ActiveRecord::Migration
  def change
    create_table :quote_likes do |t|
      t.references :quote, index: true, foreign_key: true
      t.references :like,  index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
