# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  poster_path :string
#  runtime     :string
#  sinopsis    :text
#  tagline     :string
#  title       :string
#  year        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  tmdb_id     :integer
#
class Movie < ApplicationRecord
  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres
  has_many :library_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
