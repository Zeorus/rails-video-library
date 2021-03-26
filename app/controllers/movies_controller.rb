class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("fr")

  def index
    return unless params[:query].present?

    search = Tmdb::Search.new.resource('movie').query(params[:query])
    @results = search.fetch
  end

  def add_to_library
    movie_tmdb_id = params[:movieId].to_i
    if movie = Movie.find_by(tmdb_id: movie_tmdb_id)
      if library_item = LibraryItem.find_by(user_id: current_user.id, movie_id: movie.id)
        library_item.update(in_library: true)
      else
        library_item = create_library_item(movie)
        library_item.update(in_library: true)
      end
    else
      movie = create(movie_tmdb_id)
      library_item = create_library_item(movie)
      library_item.update(in_library: true)
    end
    head :no_content
  end

  def remove_to_library
    movie = Movie.find_by(tmdb_id: params[:movieId].to_i)
    library_item = LibraryItem.find_by(user_id: current_user.id, movie_id: movie.id)
    library_item.update(in_library: false)
    head :no_content
  end

  def user_library
  end

  def user_list
  end

  private

  def create(movie_tmdb_id)
    movie_from_api = Tmdb::Movie.detail(movie_tmdb_id)
    movie = Movie.create!(title: movie_from_api["title"],
                          poster_path: movie_from_api["poster_path"],
                          sinopsis: movie_from_api["overview"],
                          year: movie_from_api["release_date"],
                          tmdb_id: movie_tmdb_id)
    movie_from_api["genres"].each do |genre|
      movie_genre = MovieGenre.new
      movie_genre.genre = Genre.find_by(tmdb_id: genre["id"])
      movie_genre.movie = movie
      movie_genre.save
    end
    return movie
  end

  def create_library_item(movie)
    library_item = LibraryItem.new
    library_item.movie = movie
    library_item.user = current_user
    library_item.movie_tmdb_id = movie.tmdb_id
    library_item.save
    return library_item
  end
end
