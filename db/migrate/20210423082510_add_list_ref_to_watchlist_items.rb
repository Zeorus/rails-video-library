class AddListRefToWatchlistItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :watchlist_items, :list, null: false, foreign_key: true
  end
end
