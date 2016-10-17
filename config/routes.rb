Rails.application.routes.draw do
  namespace :admin do
    resources :users
resources :posts
resources :admin_users

    root to: "users#index"
  end

  devise_for :users, skip: [:registrations]
  resources :posts
  root to: 'static#home'
end
