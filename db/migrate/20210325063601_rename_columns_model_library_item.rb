class RenameColumnsModelLibraryItem < ActiveRecord::Migration[6.1]
  def change
    rename_column :library_items, :in_library?, :in_library
    rename_column :library_items, :to_watch?, :to_watch
  end
end
