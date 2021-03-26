class AddIndexOnLibraryItems < ActiveRecord::Migration[6.1]
  def change
    add_index :library_items, [:user_id, :movie_id], unique: true
  end
end
