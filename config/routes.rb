Rails.application.routes.draw do
  root to: "sessions#new"
  resources :sessions, only:[:new,:create,:destroy]
  namespace :admin do
    resources :users
  end
  resources :tasks
end
