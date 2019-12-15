class PlayerStatsController < ApplicationController

    def index
        player_stats = PlayerStat.all.limit(100)
        render json: player_stats
    end

    def show
        player_stat = PlayerStat.find(params[:id])
        render json: player_stat
    end
    
end