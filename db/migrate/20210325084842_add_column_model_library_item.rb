class AddColumnModelLibraryItem < ActiveRecord::Migration[6.1]
  def change
    add_column :library_items, :movie_tmdb_id, :integer
  end
end
