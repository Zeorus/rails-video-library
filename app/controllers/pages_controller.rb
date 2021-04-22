# frozen_string_literal: true

require 'json'
require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_url

  def home
    @y = 7
    @load = "true"
    @incr = @y + 1
    @most_popular_movies = parse_url("#{@base_url}&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&sort_by=popularity.desc&page=2")['results']
    @best_2020_movies = parse_url("#{@base_url}&year=2020&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&year=2020&sort_by=popularity.desc&page=2")['results']
    @best_movies = parse_url("#{@base_url}&vote_count.gte=500&sort_by=vote_average.desc")['results'] + parse_url("#{@base_url}&vote_count.gte=500&sort_by=vote_average.desc&page=2")['results']
  end

  def most_popular_movies
    @search = "sort_by=popularity.desc"
    @movies = parse_url("#{@base_url}&#{@search}")['results'] + parse_url("#{@base_url}&#{@search}&page=2")['results']
    render 'shared/_movies'
  end

  def best_2020_movies
    @search = "year=2020&sort_by=popularity.desc"
    @movies = parse_url("#{@base_url}&#{@search}")['results'] + parse_url("#{@base_url}&#{@search}&page=2")['results']
    render 'shared/_movies'
  end

  def best_movies
    @search = "vote_count.gte=500&sort_by=vote_average.desc"
    @movies = parse_url("#{@base_url}&#{@search}")['results'] + parse_url("#{@base_url}&#{@search}&page=2")['results']
    render 'shared/_movies'
  end

  def movies_by_genre
    @search = "with_genres=#{params[:id]}"
    @movies = parse_url("#{@base_url}&#{@search}&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&#{@search}&sort_by=popularity.desc&page=2")['results']
    render 'shared/_movies'
  end

  # def home
  #   @y = params[:y].to_i
  #   if @y == 0
  #     @load = "false"
  #   else
  #     @load = "true"
  #     @incr = @y + 1
  #     @most_popular_movies = parse_url("#{@base_url}&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&sort_by=popularity.desc&page=2")['results']
  #     @best_2020_movies = parse_url("#{@base_url}&year=2020&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&year=2020&sort_by=popularity.desc&page=2")['results']
  #     @best_movies = parse_url("#{@base_url}&vote_count.gte=500&sort_by=vote_average.desc")['results'] + parse_url("#{@base_url}&vote_count.gte=500&sort_by=vote_average.desc&page=2")['results']
  #   end
  # end

  # def load_carrousel
  #   redirect_to root_path(y: params[:y].to_i)
  # end

  private

  def set_url
    @base_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['TMDB_API_KEY']}&language=fr"
  end

  def parse_url(url)
    response = open(url).read
    JSON.parse(response)
  end
end
