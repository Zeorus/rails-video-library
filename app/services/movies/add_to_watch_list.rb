module Movies
  class AddToWatchList < Service
    required do
      integer :tmdb_movie_id
      model :user
    end

    def execute
      movie = FindMovieService.new(tmdb_movie_id).find_movie
      user.towatch_movies << movie
    end
  end
end
