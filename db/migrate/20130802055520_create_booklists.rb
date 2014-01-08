class CreateBooklists < ActiveRecord::Migration
  def change
    create_table :booklists do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index :booklists, :user_id
  end
end
