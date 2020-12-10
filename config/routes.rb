Rails.application.routes.draw do
  root 'home#index'
  get '/contact' => 'static_pages#contact'
  get '/tarifs' => 'static_pages#pricing'
  get '/terms' => 'static_pages#terms'

  devise_for :users

  resources :users do 
    resources :schedules
  end
  
  resources :lessons do
    resources :teachers, only: [:show]
    resources :bookings do 
      resources :chatrooms, only: [:show, :create]
    end 
  end
  
  resources :messages, only:[:create]
  resources :credit_orders, only:[:new, :create]

  # ActionCable
  mount ActionCable.server => '/cable'

  # Admin 
  namespace :admin do
    root 'facade#index'
    resources :users
    resources :lessons
    resources :bookings
  end

end
