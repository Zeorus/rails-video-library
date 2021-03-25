# == Schema Information
#
# Table name: genres
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tmdb_id    :integer
#
class Genre < ApplicationRecord
  has_many :movie_genres
  has_many :movies, through: :movie_genres
end
