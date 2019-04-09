Rails.application.routes.draw do
  root to: "posts#index"
  resources :posts

  namespace :api do
    resources :posts
  end
end
