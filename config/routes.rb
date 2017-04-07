Rails.application.routes.draw do
  root to: 'snacks#index'
  mount Sidekiq::Web => '/sidekiq'

  resources :snacks, only: [:index, :new]
end
