Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users ,only: [:new,:create,:show]
  namespace :admin do
    resources :users
  end  
  resources :tasks
  resources :sessions
  resources :labelings
  # get 'labelings/new', to: 'labelings#new', as: 'new_labeling'
  # post 'labelings', to: 'labelings#create'
end
