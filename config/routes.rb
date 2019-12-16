Rails.application.routes.draw do
  resources :seasons
  resources :players, only: [:index, :show]
  resources :teams, only: [:index, :show]
  resources :player_stats, only: [:index, :show]
  resources :games, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/players/:id/:season', to: "players#player_season"
  get '/teams/:id/:season', to: "teams#season_roster"

end
