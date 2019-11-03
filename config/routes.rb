Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users ,only: [:new,:create]
  namespace :admin do
    resources :users
  end  
  resources :tasks
  resources :sessions
end
