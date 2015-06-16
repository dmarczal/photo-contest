Rails.application.routes.draw do

  namespace :admin do
    resources :pages
  end

  devise_for :users

  get 'contests/archive'


  get 'contests/list'

  get 'contests/show'

  root 'home#index'
  get '/admin' => 'admin/home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  namespace :admin do
    root to: 'home#index'
    get    'sign_in'   => 'sessions#new'
    post   'sign_in'   => 'sessions#create'

    resources :contests
  end
  
  get ':permalink' => 'admin/pages#route'
end
