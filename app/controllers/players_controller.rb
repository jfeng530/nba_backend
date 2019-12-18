class PlayersController < ApplicationController

    def index
        players = Player.all
        render json: players
    end

    def show
        player = Player.find(params[:id])
        render json: player
    end

    def season_stats
        player = Player.find(params[:id])
        render json: player.show_stats
    end
    
end
