# == Schema Information
#
# Table name: movie_genres
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint           not null
#  movie_id   :bigint           not null
#
# Indexes
#
#  index_movie_genres_on_genre_id  (genre_id)
#  index_movie_genres_on_movie_id  (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#  fk_rails_...  (movie_id => movies.id)
#
class MovieGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :movie
end
