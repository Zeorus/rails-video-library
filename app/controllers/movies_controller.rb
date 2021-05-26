# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show find_or_create find_or_create_js]

  def index
    return unless params[:query].present?

    search = Tmdb::Search.new.resource('movie').query(params[:query])
    @results = search.fetch
    @lists = current_user.lists if user_signed_in?
  end

  def show
    @movie = Movie.find(params[:id])
    @lists = current_user.lists if user_signed_in?
    @youtube_videos = YoutubeVideoIdService.new(@movie.title).find_video
    return unless user_signed_in?
    @review = Review.joins(:movie).find_by(user_id: current_user.id, movie: { id: @movie.id })
    @review = Review.new if @review.nil?
  end

  def find_or_create
    @movie = FindMovieService.new(params[:movie]['id']).find_movie
    redirect_to movie_path(@movie)
  end

  def find_or_create_js
    @movie = FindMovieService.new(params[:movieId].to_i).find_movie
    redirect_to movie_path(@movie)
  end
end
