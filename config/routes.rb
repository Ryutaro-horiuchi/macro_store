Rails.application.routes.draw do
  namespace :api do
    post 'login', to: 'sessions#create'
  end
  namespace :api do
    post 'users', to: 'users#create'
  end
  root to: 'home#index'
  get '*path', to: 'home#index'
end
