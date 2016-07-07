Rails.application.routes.draw do
  devise_for :users
  get 'home' => 'home#index'
  resources :users, only: [:index, :show]
  resources :locations, only: [:create, :update] do
    post :share, on: :member
  end
  resource :friendships, only: [:create, :destroy, :update]
  root 'home#index'
end
