Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'gossips#index'

  resources :gossips

  resources :users

  resources :city, only: [:show]

  resources :comments

  resources :sessions, only: [:new, :create, :destroy]

  get '/team', to: 'static_pages#team'

  get '/contact', to: 'static_pages#contact'

end
