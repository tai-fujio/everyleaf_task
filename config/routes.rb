Rails.application.routes.draw do
  namespace :admin do
    get 'users/indes'
    get 'users/new'
    get 'users/show'
    get 'users/edit'
  end
  root "tasks#index"
  resources :tasks
end
