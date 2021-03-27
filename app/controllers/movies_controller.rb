# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    return unless params[:query].present?

    search = Tmdb::Search.new.resource('movie').query(params[:query])
    @results = search.fetch
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

  def user_library; end

  def user_list; end
end
