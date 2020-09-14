Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :search_items # REMOVE ROUTES YOU DON'T NEED
end
