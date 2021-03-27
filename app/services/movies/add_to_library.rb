# frozen_string_literal: true

module Movies
  class AddToLibrary < Service
    required do
      integer :tmdb_movie_id
      model :user
    end

    def execute
      user.movies << movie
    end

    private

    def tmdb_movie
      Tmdb::Movie.detail(tmdb_movie_id)
    end

    def movie
      movie = tmdb_movie
      Movie.create_with(
        title: movie['title'],
        poster_path: movie['poster_path'],
        sinopsis: movie['overview'],
        year: movie['release_date'],
        genres: Genre.where(tmdb_id: movie['genres'].map { |genre| genre['id'] })
      ).find_or_create_by(tmdb_id: tmdb_movie_id)
    end
  end
end
