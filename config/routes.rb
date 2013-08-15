require 'grape'
require 'api'
require 'entities'

Sg::Application.routes.draw do
  mount Sg::Api => '/'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :profiles, only: [:show, :edit, :update]
  get "pages/index"
  get "pages/about"
  get "pages/example"
  
  get '/blog' => 'blog#index'

  get '/p/:id' => 'papers#show', :as => 'paper'

  match '', to: 'blog#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }, via: [:get]
  match ':id', to: 'blog#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }, via: [:get]

  resources :gists
  resources :papers

  match 'vote_up' => 'gists#vote_up', via: [:get]
  match 'vote_down' => 'gists#vote_down', via: [:get]

  match 'papers_metadata' => 'papers#metadata', via: [:get]

  root :to => 'pages#index'

  match 'doi/*identifiers' => 'identifiers#doi', via: [:get], format: false, as: :doi
  match 'arxiv/*identifiers' => 'identifiers#arxiv', via: [:get], format: false, as: :arxiv

  get "tags/search"
  get "tags" => 'tags#index'
  get "tag/:name" => 'tags#show', as: :tag

  namespace :admin do
    resources :users
    resources :posts
    resources :gists
    root :to => 'base#index'
  end
end
