Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "display-followers" => 'pages#display_followers'

  resources :search_items # REMOVE ROUTES YOU DON'T NEED
end
