Rails.application.routes.draw do
  root to: 'snacks#index'

  resources :snacks, only: [:index]
end
