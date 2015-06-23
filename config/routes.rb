Rails.application.routes.draw do

  devise_for :users

  root to:'home#index'

  get 'contests/archive'
  get '/contests'   => 'contests#list' 
  get 'contests/:id' => 'contests#show', as: 'contest'
  get '/contests/:id/participate'   => 'contests#new_participant', as: 'new_inscription'
  #post '/contests/:id/participate'   => 'contests#register'
  get 'contests/open'
  get 'contests/show'
  
  get 'photographers/list'
  get 'photographers/:id' => 'photographers#show', as: 'photographers'

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
