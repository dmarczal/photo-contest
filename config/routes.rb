Rails.application.routes.draw do

  devise_for :users

  get 'contests/archive'

  get 'contests/list'

  get 'contests/show'

  root 'home#index'

  get '/admin' => 'admin/home#index'

  namespace :admin do
    root to: 'home#index'
    get    'sign_in'   => 'sessions#new'
    post   'sign_in'   => 'sessions#create'

    resources :contests
  end

end
