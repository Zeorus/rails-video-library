class RemoveColumnTmdbIdLibraryItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :library_items, :movie_tmdb_id
  end
end
