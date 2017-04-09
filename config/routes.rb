Rails.application.routes.draw do
  root to: 'snacks#index'
  mount Sidekiq::Web => '/sidekiq'

  resources :snacks, only: [:index, :new, :create, :update]
  post '/update_vote_count', as: 'update_vote_count', to: 'snacks#update_vote_count'
end
