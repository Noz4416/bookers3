class AddBookIdToFavorites < ActiveRecord::Migration[6.1]
  def change
    change_table :favorites do |t|
      t.references :book, null: false, foreign_key: true
    end
  end
end
