Rails.application.routes.draw do
    root 'static_pages#home'
  get '/home', to: 'static_pages#private_home'
  get  '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
