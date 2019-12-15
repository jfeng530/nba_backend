Rails.application.routes.draw do
  resources :players, only: [:index, :show]
  resources :teams, only: [:index, :show]
  resources :player_stats, only: [:index, :show]
  resources :games, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
