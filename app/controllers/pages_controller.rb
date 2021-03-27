# frozen_string_literal: true

require 'json'
require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    base_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['TMDB_API_KEY']}&language=fr"
    @news_movies = parse_url(base_url)['results'] + parse_url("#{base_url}&page=2")['results']
    @most_popular_movies = parse_url("#{base_url}&sort_by=popularity.desc")['results'] + parse_url("#{base_url}&sort_by=popularity.desc&page=2")['results']
    @best_2020_movies = parse_url("#{base_url}&year=2020&sort_by=popularity.desc")['results'] + parse_url("#{base_url}&year=2020&sort_by=popularity.desc&page=2")['results']
    @best_movies = parse_url("#{base_url}&vote_count.gte=500&sort_by=vote_average.desc")['results'] + parse_url("#{base_url}&vote_count.gte=500&sort_by=vote_average.desc&page=2")['results']
  end

  private

  def parse_url(url)
    response = open(url).read
    JSON.parse(response)
  end
end
