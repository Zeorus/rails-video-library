class RemoveColumnsLibraryItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :library_items, :in_library
    remove_column :library_items, :to_watch
  end
end
