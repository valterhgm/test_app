Rails.application.routes.draw do
  resources :users
  resources :sessions
  root to: "sessions#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
