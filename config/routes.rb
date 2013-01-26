Sg::Application.routes.draw do

  devise_for :users

  get "pages/index"
  get '/blog' => 'blog#index'

  root :to => 'pages#index'

  namespace :admin do
    resources :users
    resources :posts
    root :to => 'base#index'
  end
end
