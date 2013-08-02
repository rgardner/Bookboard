class RenameSubmittedByToUserId < ActiveRecord::Migration
  def change
    rename_column :books, :submitted_by, :user_id
  end
end
