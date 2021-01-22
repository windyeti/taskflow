Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  resources :projects, only: [:index, :create, :show, :edit, :update, :destroy]
end
