class PlayersController < ApplicationController

    def index
        if params[:search]
            names = params[:search].split(' ')
            names[1] = "" if names.length === 1 
            players = Player.where("(lower(first_name) LIKE ? OR lower(last_name) LIKE ?) OR (lower(first_name) LIKE ? OR lower(last_name) LIKE ?)", 
                                    names[0], names[1], names[1], names[0])
            render json: players
        else
            players = Player.all[0..10]
            render json: players
        end
    end

    def show
        player = Player.find(params[:id])
        render json: player
    end

    def season_stats
        player = Player.find(params[:id])
        render json: player.show_stats
    end

    def teams
        player = Player.find(params[:id])
        render json: player.teams_played
    end
    
end
