Rails.application.routes.draw do

  devise_for :users
  
  root to:'home#index'

  get 'contests/archive'

  get 'contests/list'

  get 'contests/open'

  get 'contests/show'

  get '/admin' => 'admin/home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  namespace :admin do
    root to: 'home#index'
    get    'sign_in'   => 'sessions#new'
    post   'sign_in'   => 'sessions#create'

    resources :contests
  end

end
