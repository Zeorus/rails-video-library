Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :movies, only: [ :index ]
  
  post 'addlibrary', to: 'movies#add_to_library'
  post 'removelibrary', to: 'movies#remove_to_library'
  get 'library', to: 'movies#user_library' 
  get 'list', to: 'movies#user_list' 

end
