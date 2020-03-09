Rails.application.routes.draw do
  resources :comments
  root to: "posts#index"
  resources :posts, only: [:index, :new, :create, :show]
  resources :other_posts, only: [:index, :new, :create, :show]

  namespace :api do
    resources :other_posts
    resources :posts
  end
end
