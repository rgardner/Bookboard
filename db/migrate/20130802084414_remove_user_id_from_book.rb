class RemoveUserIdFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :user_id
  end
end
