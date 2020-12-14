Rails.application.routes.draw do
  devise_for :users

  root to: "articles#index"
  resources :articles, only: [:index, :new, :create, :show, :destroy] do
    resources :messages, only: [:index, :create]
  end
  resources :users, only: [:show, :edit, :update]

end
