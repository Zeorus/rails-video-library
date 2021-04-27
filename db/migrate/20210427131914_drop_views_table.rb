class DropViewsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :views
  end
end
