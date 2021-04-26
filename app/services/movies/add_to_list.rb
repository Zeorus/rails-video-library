module Movies
  class AddToList < Service
    required do
      integer :tmdb_movie_id
      integer :list_id
      model :user
    end

    def execute
      movie = FindMovieService.new(tmdb_movie_id).find_movie
      list = List.find(list_id)
      WatchlistItem.create!(movie: movie, user: user, list: list)
    end
  end
end
