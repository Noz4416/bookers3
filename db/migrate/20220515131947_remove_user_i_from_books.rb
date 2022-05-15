class RemoveUserIFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :user_i, :integer
  end
end
