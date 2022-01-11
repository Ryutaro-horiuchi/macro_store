Rails.application.routes.draw do
  namespace :api do
    post 'login', to: 'sessions#create'
    post 'signUp', to: 'users#create'
    patch 'update', to: 'users#update'
    get 'users/me', to: 'users#me'
    post 'bookmarks/create', to: 'bookmarks#create'
    post 'bookmarks/destroy', to: 'bookmarks#destroy'
    post '/search/name', to: 'foods#search_name'
    post '/search/nutrient', to: 'foods#search_nutrient'
  end
  root to: 'home#index'
  get '*path', to: 'home#index'
end

# Rails.application.routes.draw do
#   namespace :api do
#     post 'login', to: 'sessions#create'
#     post 'signUp', to: 'users#create'
#     patch 'update', to: 'users#update'
#     get 'users/me', to: 'users#me'
#     post 'bookmarks/create'
#     post 'bookmarks/destroy'
#     post '/search/name', to: 'foods#search_name'
#     post '/search/nutrient', to: 'foods#search_nutrient'
#   end
#   root to: 'home#index'
#   get '*path', to: 'home#index'
# end