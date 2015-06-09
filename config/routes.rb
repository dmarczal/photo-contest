Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    root to: 'home#index'
    get    'sign_in'   => 'sessions#new'
    post   'sign_in'   => 'sessions#create'

    resources :contests
  end

  root to: 'home#index'
end
