class ListsController < ApplicationController
  before_action :find_list, only: [ :update, :destroy ]

  def index
    @lists = {}
    lists = List.where(user_id: current_user.id)
    lists.each do |list|
      movies = Movie.joins(:watchlist_items).where(watchlist_items: { user_id: current_user.id, list_id: list.id })
      @lists[list] = movies
    end
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save!
      redirect_back(fallback_location: root_path, notice: "Votre liste a été créée avec succès.")
    else
      redirect_back(fallback_location: root_path, notice: "Erreur, votre liste n'a pas été sauvegardée.")
    end
  end

  def update
    if @list.update(list_params)
      redirect_back(fallback_location: root_path, notice: "Votre liste a été renommée avec succès.")
    else
      redirect_back(fallback_location: root_path, notice: "Erreur, votre liste n'a pas été sauvegardée.")
    end
  end

  def destroy
    @list.destroy
    redirect_back(fallback_location: root_path, notice: "Votre liste a été supprimée avec succès.")
  end

  def add_to_list
    movie = FindMovieService.new(params[:movieId].to_i).find_movie
    list = List.find(params[:listId].to_i)
    WatchlistItem.create!(movie: movie, user: current_user, list: list)

    head :created
  end

  def user_lists
    lists = List.where(user_id: current_user.id)
    render json: { user_lists: lists }
  end

  def get_list_name
    list = List.find(params[:listId].to_i)
    render json: { list_name: list.name }
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
