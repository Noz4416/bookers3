class RenamePostColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :favorites, :posts
    remove_reference :favorites, :post, index: true
  end
end
