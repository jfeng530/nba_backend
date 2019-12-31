Rails.application.routes.draw do
  resources :stats
  resources :seasons
  resources :players, only: [:index, :show]
  resources :teams, only: [:index, :show]
  resources :player_stats, only: [:index, :show]
  resources :games, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/teams/:id/:season', to: "teams#season_roster"
  get '/players/:id/stats', to: "players#season_stats"
  get '/seasons/:firstid/:secondid', to: "seasons#simulate_game"
  
end
