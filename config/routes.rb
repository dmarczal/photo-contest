Rails.application.routes.draw do

  namespace :admin do
    resources :pages
  end

  get 'contests/archive'

  devise_for :users

  root to:'home#index'

  get 'contests/hall_of_fame' => 'contests#hall_of_fame', as: 'hall_of_fame'
  get  'contests/archive'
  get  '/contests'   => 'contests#list'
  get  'contests/:id' => 'contests#show', as: 'contest'
 
  resources :participants, except: [:destroy]
  
  get 'contests/open'
  get 'contests/show'
  
  get 'photographers/list', as: 'photographer_list'
  get 'photographers/:id' => 'photographers#show', as: 'photographer'

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
  
  get ':permalink' => 'admin/pages#route'
end
