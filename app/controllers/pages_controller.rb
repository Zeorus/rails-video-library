# frozen_string_literal: true

require 'json'
require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_url

  def home
    @lists = current_user.lists if user_signed_in?
    @most_popular_movies = parse_url("#{@base_url}&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&sort_by=popularity.desc&page=2")['results']
    @best_2020_movies = parse_url("#{@base_url}&year=2020&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&year=2020&sort_by=popularity.desc&page=2")['results']
    @best_movies = parse_url("#{@base_url}&vote_count.gte=500&sort_by=vote_average.desc")['results'] + parse_url("#{@base_url}&vote_count.gte=500&sort_by=vote_average.desc&page=2")['results']
  end

  def most_popular_movies
    @lists = current_user.lists if user_signed_in?
    @search = 'sort_by=popularity.desc'
    @movies = parse_url("#{@base_url}&#{@search}")['results'] + parse_url("#{@base_url}&#{@search}&page=2")['results']
    render 'shared/_movies'
  end

  def best_2020_movies
    @lists = current_user.lists if user_signed_in?
    @search = 'year=2020&sort_by=popularity.desc'
    @movies = parse_url("#{@base_url}&#{@search}")['results'] + parse_url("#{@base_url}&#{@search}&page=2")['results']
    render 'shared/_movies'
  end

  def best_movies
    @lists = current_user.lists if user_signed_in?
    @search = 'vote_count.gte=500&sort_by=vote_average.desc'
    @movies = parse_url("#{@base_url}&#{@search}")['results'] + parse_url("#{@base_url}&#{@search}&page=2")['results']
    render 'shared/_movies'
  end

  def movies_by_genre
    @lists = current_user.lists if user_signed_in?
    @search = "with_genres=#{params[:id]}"
    @movies = parse_url("#{@base_url}&#{@search}&sort_by=popularity.desc")['results'] + parse_url("#{@base_url}&#{@search}&sort_by=popularity.desc&page=2")['results']
    render 'shared/_movies'
  end

  private

  def set_url
    @base_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['TMDB_API_KEY']}&language=fr"
  end

  def parse_url(url)
    response = open(url).read
    JSON.parse(response)
  end
end
