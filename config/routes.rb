Rails.application.routes.draw do
  
  
  get 'avatars/create'
  root to: 'events#index'

  get 'static_pages/index'
  devise_for :users
  resources :users, only: [:update, :edit]

  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end
  
  resources :events do 
    resources :attendances, only: [:create, :destroy]
    resources :orders, only: [:new, :create]
  end

end
