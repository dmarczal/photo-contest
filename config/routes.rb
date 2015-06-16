Rails.application.routes.draw do

  devise_for :users

  root to:'home#index'

  get 'contests/archive'
  get '/contests'   => 'contests#list' 
  get 'contests/show'
  
  get 'photographers/list'
  get 'photographers/show'

  get '/admin' => 'admin/home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  namespace :admin do
    
    root to: 'home#index'
    get      'login'   => 'sessions#new'
    post     'login'   => 'sessions#create'
    delete   'logout'   => 'sessions#destroy'

    resources :contests
  end

end
