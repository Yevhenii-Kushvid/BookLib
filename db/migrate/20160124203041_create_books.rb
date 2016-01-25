class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :picture
      t.text :context
      t.boolean :is_draft

      t.timestamps null: false
    end
  end
end
