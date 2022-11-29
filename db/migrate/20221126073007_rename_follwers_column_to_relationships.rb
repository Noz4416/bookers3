class RenameFollwersColumnToRelationships < ActiveRecord::Migration[6.1]
  def change
    rename_column :relationships, :follwer_id, :follower_id
    rename_column :relationships, :follwed_id, :followed_id
  end
end
