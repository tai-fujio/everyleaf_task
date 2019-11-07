Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users ,only: [:new,:create,:show]
  namespace :admin do
    resources :users
    resources :labelings
  end  
  resources :tasks
  resources :sessions
  delete 'labels/:id', to: 'labels#destroy', as: 'label'
  post 'labels', to: 'labels#create'
end
