class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @movie = Movie.find(params[:movie_id])
    @review.movie = @movie
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: "Votre avis a été correctement ajouté"
    else
      redirect_to movie_path(@movie), alert: "Erreur, votre avis n'a pas été sauvegardé"
    end
  end

  def update
    @review = Review.find(params[:id])
    @movie = Movie.find(params[:movie_id])
    if @review.update(review_params)
      redirect_to movie_path(@movie), notice: "Votre avis a été correctement modifié"
    else
      redirect_to movie_path(@movie), alert: "Erreur, votre avis n'a pas été sauvegardé"
    end
  end
  
  private

  def review_params
    params.require(:review).permit(:rate, :content)
  end
end
