Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    root to: 'home#index'
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'

    resources :contests
  end

  root to: 'home#index'
end
