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
    @review = Review.joins(:movie).find_by(user_id: current_user.id, movie: { id: @movie.id })
    if @review == nil
      @review = Review.new
    end
  end

  def find_or_create
    @movie = find_or_create_by(params[:movie]["id"])
    redirect_to movie_path(@movie)
  end

  def add_to_library
    outcome = Movies::AddToLibrary.run(
      tmdb_movie_id: params[:movieId].to_i,
      user: current_user
    )

    # TODO: il y a mieux a faire pour la gestion des retours mais je te laisserai reflechir a ca
    head :no_content if outcome.success?
  end

  def remove_from_library
    movie = Movie.find_by(tmdb_id: params[:movieId].to_i)
    LibraryItem.find_by(user_id: current_user.id, movie_id: movie.id).destroy
    head :no_content
  end

  def user_library
    @movies = Movie.joins(:library_items).where(library_items: { user_id: current_user.id })
  end

  def user_list; end

  private

  def tmdb_movie(tmdb_movie_id)
    Tmdb::Movie.detail(tmdb_movie_id)
  end
  
  def find_or_create_by(tmdb_movie_id)
    movie = tmdb_movie(tmdb_movie_id)
    Movie.create_with(
      title: movie['title'],
      poster_path: movie['poster_path'],
      sinopsis: movie['overview'],
      year: movie['release_date'],
      tagline: movie['tagline'],
      runtime: movie['runtime'],
      genres: Genre.where(tmdb_id: movie['genres'].map { |genre| genre['id'] })
    ).find_or_create_by(tmdb_id: tmdb_movie_id)
  end
end
