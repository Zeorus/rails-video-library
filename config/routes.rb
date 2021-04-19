Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :movies, only: [ :index, :show ] do
    resources :reviews, only: [ :create, :update ]
  end

  get 'mostpopularmovies', to: 'pages#most_popular_movies'
  get 'best2020movies', to: 'pages#best_2020_movies'
  get 'bestmovies', to: 'pages#best_movies'

  post 'loadcarrousel', to: 'pages#load_carrousel'
  
  post 'addseen', to: 'movies#add_to_seen'
  post 'removeseen', to: 'movies#remove_from_seen'

  post 'addwatchlist', to: 'movies#add_to_watchlist'
  post 'removewatchlist', to: 'movies#remove_from_watchlist'

  get 'library', to: 'movies#user_library'
  get 'list', to: 'movies#user_list'
  get 'findorcreate', to: 'movies#find_or_create'

end
