Rails.application.routes.draw do
  namespace :api do
    post 'login', to: 'sessions#create'
    post 'users', to: 'users#create'
    get 'users/me', to: 'users#me'
    get 'bookmarks/index'
    post 'bookmarks/create'
    post 'bookmarks/destroy'
    post '/search/name', to: 'foods#search_name'
    post '/search/nutrient', to: 'foods#search_nutrient'
  end
  root to: 'home#index'
  get '*path', to: 'home#index'
end
