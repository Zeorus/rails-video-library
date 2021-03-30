class FindMovieService
  def initialize(tmdb_movie_id)
    @tmdb_movie_id = tmdb_movie_id
  end

  def find_movie
    movie = tmdb_movie
    Movie.create_with(
      title: movie['title'],
      poster_path: movie['poster_path'],
      sinopsis: movie['overview'],
      year: movie['release_date'],
      tagline: movie['tagline'],
      runtime: movie['runtime'],
      genres: Genre.where(tmdb_id: movie['genres'].map { |genre| genre['id'] })
    ).find_or_create_by(tmdb_id: @tmdb_movie_id)
  end

  private

  def tmdb_movie
    Tmdb::Movie.detail(@tmdb_movie_id)
  end
end
