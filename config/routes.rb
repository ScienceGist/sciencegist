require 'grape'
require 'api_v1'
require 'entities'

Sg::Application.routes.draw do
  
  mount Sg::ApiV1 => '/'

  devise_for :users

  get "pages/index"
  get "pages/about"
  get '/blog' => 'blog#index'

  get '/p/:id' => 'papers#show', :as => 'paper'

  match '', to: 'blog#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }, via: [:get]

  resources :gists
  resources :papers

  match 'vote_up' => 'gists#vote_up', via: [:get]
  match 'vote_down' => 'gists#vote_down', via: [:get]

  match 'papers_metadata' => 'papers#metadata', via: [:get]

  root :to => 'pages#index'

  namespace :admin do
    resources :users
    resources :posts
    root :to => 'base#index'
  end
end
