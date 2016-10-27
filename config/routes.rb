Rails.application.routes.draw do
  resources :audit_logs, except: [:new,:edit,:destroy] do 
    member do 
      get :confirm
    end 
  end 
  
  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users
    root to: "users#index"
  end

  devise_for :users, skip: [:registrations]
  resources :posts do 
    member do 
      get :approve
    end 
  end 
  root to: 'static#home'
end
