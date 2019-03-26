Rails.application.routes.draw do
  root to: "posts#index"
  resources :posts, only: [:index, :new, :create, :show]

  namespace :api do
    resources :posts
  end

  namespace :awesome do
    resources :posts, only: [:index, :new, :create, :show]

    namespace :api do
      resources :posts
    end
  end
end
