Rails.application.routes.draw do
  root to: "users#index"
  get '/users/:id' , to: 'users#show'
  get '/users/:id/posts' , to: 'posts#index'
  get '/users/:id/posts/:post_id' , to: 'posts#show'

  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create]
  end

  resources :comments, only: %i[destroy]
  resources :likes, only: %i[destroy]

end
