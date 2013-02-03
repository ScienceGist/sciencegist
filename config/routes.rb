Sg::Application.routes.draw do

  devise_for :users

  get "pages/index"
  get '/blog' => 'blog#index'

  get '/p/:id' => 'papers#show', :as => 'paper'

  match '', to: 'blog#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  resources :gists

  match 'papers_metadata' => 'papers#metadata'

  root :to => 'pages#index'

  namespace :admin do
    resources :users
    resources :posts
    root :to => 'base#index'
  end
end
