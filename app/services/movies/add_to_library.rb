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
      Movie.create_with(
        title: tmdb_movie['title'],
        poster_path: tmdb_movie['poster_path'],
        sinopsis: tmdb_movie['overview'],
        year: tmdb_movie['release_date'],
        genre_ids: Genre.where(tmdb_id: tmdb_movie['genres'].map { |genre| genre['id'] })
      ).find_or_create_by(tmdb_id: movie_tmdb_id)
    end
  end
end
