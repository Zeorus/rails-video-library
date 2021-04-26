Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :movies, only: [ :index, :show ] do
    resources :reviews, only: [ :create, :update ]
  end

  resources :watchlist_items, only: [ :update, :destroy ]

  resources :lists, only: [ :index, :create, :update, :destroy ]

  get 'mostpopularmovies', to: 'pages#most_popular_movies'
  get 'best2020movies', to: 'pages#best_2020_movies'
  get 'bestmovies', to: 'pages#best_movies'
  get 'moviesbygenre', to: 'pages#movies_by_genre'

  post 'loadcarrousel', to: 'pages#load_carrousel'

  post 'addtolist', to: 'lists#add_to_list'
  post 'watchlistitem', to: 'watchlist_items#watchlist_item?'
  post 'userlists', to: 'lists#user_lists'
  post 'listname', to: 'lists#get_list_name'

  post 'findorcreatejs', to: 'movies#find_or_create_js'

  get 'findorcreate', to: 'movies#find_or_create'

end
