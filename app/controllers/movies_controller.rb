class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("fr")

  def index
    return unless params[:query].present?

    search = Tmdb::Search.new.resource('movie').query(params[:query])
    @results = search.fetch
  end

end
