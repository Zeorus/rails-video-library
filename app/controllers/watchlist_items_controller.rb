class WatchlistItemsController < ApplicationController

  def update
    watchlist_item = WatchlistItem.find(params[:id])
    list = List.find(params[:listId])
    watchlist_item.update(list: list)
    redirect_back(fallback_location: root_path, notice: "\"#{watchlist_item.movie.title}\" a été changé de liste.")
  end

  def destroy
    list_item = WatchlistItem.find(params[:id])
    movie_title = list_item.movie.title
    list_item.destroy
    redirect_back(fallback_location: root_path, notice: "\"#{movie_title}\" a été retiré de vos listes.")
  end

  def watchlist_item?
    watchlist_item = WatchlistItem.joins(:movie).find_by(user_id: current_user.id, movie: { tmdb_id: params[:movieId] })
    render json: { watchlist_item: watchlist_item }
  end
end
