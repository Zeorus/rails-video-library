class DropTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :library_items
    drop_table :list_items
  end
end
