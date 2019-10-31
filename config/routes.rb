Rails.application.routes.draw do
  get 'sessions/new'
  resources :sessions, only:[:new,:create,:destroy]
  namespace :admin do
    resources :users
  end
  root to: "tasks#index"
  resources :tasks
end
