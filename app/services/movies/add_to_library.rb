# frozen_string_literal: true

module Movies
  class AddToLibrary < Service
    required do
      integer :tmdb_movie_id
      model :user
    end

    def execute
      movie = FindMovieService.new(tmdb_movie_id).find_movie
      user.movies << movie
    end
end
