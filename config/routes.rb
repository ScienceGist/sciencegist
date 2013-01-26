Tsgb::Application.routes.draw do
  get "base/index"

  devise_for :users

  get "pages/index"
  root :to => 'pages#index'

end
