class AddColumnsToLibraryItem < ActiveRecord::Migration[6.1]
  def change
    add_column :library_items, :to_watch?, :boolean, default: false
    add_column :library_items, :in_library?, :boolean, default: false
  end
end
