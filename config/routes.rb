Rails.application.routes.draw do
  namespace :api do
    post 'login', to: 'sessions#create'
    post 'users', to: 'users#create'
    post '/search', to: 'foods#search'
    get 'users/me', to: 'users#me'
  end
  root to: 'home#index'
  get '*path', to: 'home#index'
end
