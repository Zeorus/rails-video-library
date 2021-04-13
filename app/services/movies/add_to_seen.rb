# frozen_string_literal: true

module Movies
  class AddToSeen < Service
    required do
      integer :tmdb_movie_id
      model :user
    end

    def execute
      movie = FindMovieService.new(tmdb_movie_id).find_movie
      user.seen_movies << movie
    end
  end
end
