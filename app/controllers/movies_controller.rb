class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    return unless params[:query].present?

    url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movies-by-title&title=#{params[:query]}")
    results = JSON.parse(build_request(url).body)["movie_results"]
    
    @movies = []

    return if results == nil

    results.each do |result|
      url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movie-details&imdb=#{result['imdb_id']}")
      movie = JSON.parse(build_request(url).body)

      url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movies-images-by-imdb&imdb=#{result['imdb_id']}")
      movie["poster"] = JSON.parse(build_request(url).body)["poster"]
      @movies << movie
    end

    return @movies
  end

  private

  def build_request(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = ENV['RAPIDAPI_KEY']
    request["x-rapidapi-host"] = 'movies-tvshows-data-imdb.p.rapidapi.com'

    response = http.request(request)
  end
end
