Rails.application.routes.draw do
  resources :comments
  root to: "posts#index"
  resources :posts

  namespace :api do
    resources :posts
  end
end
