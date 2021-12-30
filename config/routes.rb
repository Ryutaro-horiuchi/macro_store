Rails.application.routes.draw do
  namespace :api do
    post 'login', to: 'sessions#create'
    post 'users', to: 'users#create'
    get 'bookmarks/index'
    get 'bookmarks/create'
    get 'bookmarks/destroy'
    post '/search/name', to: 'foods#search_name'
    post '/search/nutrient', to: 'foods#search_nutrient'
    get 'users/me', to: 'users#me'
  end
  root to: 'home#index'
  get '*path', to: 'home#index'
end
