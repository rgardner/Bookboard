class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :submitted_by
      t.string :author
      t.string :title

      t.timestamps
    end
    add_index :books, :submitted_by
  end
end
