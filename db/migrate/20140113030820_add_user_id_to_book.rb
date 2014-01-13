class AddUserIdToBook < ActiveRecord::Migration
  def change
    remove_column :books, :booklist_id, :string
    add_column :books, :user_id, :integer
    add_index  :books, :user_id
  end
end
