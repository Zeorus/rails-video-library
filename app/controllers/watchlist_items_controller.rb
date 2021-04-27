class WatchlistItemsController < ApplicationController

  def update
    watchlist_item = WatchlistItem.find(params[:id])
    list = List.find(params[:listId])
    watchlist_item.update(list: list)
    head :ok
  end

  def destroy
    list_item = WatchlistItem.find(params[:id])
    list_item.destroy
    head :ok
  end

  def watchlist_item?
    watchlist_item = WatchlistItem.joins(:movie).find_by(user_id: current_user.id, movie: { tmdb_id: params[:movieId] })
    render json: { watchlist_item: watchlist_item }
  end
end
