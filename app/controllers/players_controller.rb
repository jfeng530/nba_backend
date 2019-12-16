class PlayersController < ApplicationController

    def index
        players = Player.all
        render json: players
    end

    def show
        player = Player.find(params[:id])
        render json: player
    end

    def player_season
        player = Player.find(params[:id])
        # byebug
        game_stats = player.player_stats.select{|stat| stat.game.season == params[:season].to_i}
        render json: game_stats
    end
    
end
