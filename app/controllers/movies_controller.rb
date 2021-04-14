# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :find_or_create]

  def index
    return unless params[:query].present?

    search = Tmdb::Search.new.resource('movie').query(params[:query])
    @results = search.fetch
  end

  def show
    @movie = Movie.find(params[:id])
    @youtube_videos = YoutubeVideoIdService.new(@movie.title).find_video
    if user_signed_in?
      @review = Review.joins(:movie).find_by(user_id: current_user.id, movie: { id: @movie.id })
      if @review == nil
        @review = Review.new
      end
    end
  end

  def find_or_create
    @movie = FindMovieService.new(params[:movie]["id"]).find_movie
    redirect_to movie_path(@movie)
  end

  def add_to_seen
    outcome = Movies::AddToSeen.run(
      tmdb_movie_id: params[:movieId].to_i,
      user: current_user
    )

    head :no_content if outcome.success?
  end

  def remove_from_seen
    movie = Movie.find_by(tmdb_id: params[:movieId].to_i)
    View.find_by(user_id: current_user.id, movie_id: movie.id).destroy
    redirect_back(fallback_location: root_path) 
  end

  def add_to_watchlist
    outcome = Movies::AddToWatchList.run(
      tmdb_movie_id: params[:movieId].to_i,
      user: current_user
    )

    head :no_content if outcome.success?
  end

  def remove_from_watchlist
    movie = Movie.find_by(tmdb_id: params[:movieId].to_i)
    WatchlistItem.find_by(user_id: current_user.id, movie_id: movie.id).destroy
    redirect_back(fallback_location: root_path) 
  end

  def user_library
    @movies = current_user.seen_movies
  end

  def user_list
    @movies = current_user.towatch_movies
  end
end
