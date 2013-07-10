require 'grape'
#require 'api_v1'

Sg::Application.routes.draw do
  
  mount Sg::ApiV1 => '/'

  devise_for :users

  get "pages/index"
  get '/blog' => 'blog#index'

  get '/p/:id' => 'papers#show', :as => 'paper'

  match '', to: 'blog#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  resources :gists
  resources :papers

  match 'vote_up' => 'gists#vote_up'
  match 'vote_down' => 'gists#vote_down'

  match 'papers_metadata' => 'papers#metadata'

  root :to => 'pages#index'

  namespace :admin do
    resources :users
    resources :posts
    root :to => 'base#index'
  end
end
