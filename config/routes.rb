Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  root to: 'projects#index'
  resources :projects, only: [:index, :create, :show, :edit, :update, :destroy]
end
