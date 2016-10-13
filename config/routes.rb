Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root to: 'static#home'
end
