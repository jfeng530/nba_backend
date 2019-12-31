class SeasonsController < ApplicationController

    def index
        seasons = Season.all
        render json: seasons
    end

    def show
        season = Season.find(params[:id])
        render json: season
    end

    def simulate_game
        team1 = Season.find(params[:firstid])
        team2 = Season.find(params[:secondid])
        team1sim = team1.sim_stats
        team2sim = team2.sim_stats
        render json: {
            team1: {
                "team": team1.team,
                "stats": team1sim
            }, 
            team2: {
                "team": team2.team,
                "stats": team2sim
            }
        }
    end

end
