class AddBooklistIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :booklist_id, :integer
    add_index  :books, :booklist_id
  end
end
