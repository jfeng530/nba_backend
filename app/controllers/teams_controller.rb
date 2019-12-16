class TeamsController < ApplicationController

    def index
        teams = Team.all
        render json: teams
    end

    def show
        team = Team.find(params[:id])
        byebug
        render json: team
    end
    
    def season_roster
        team = Team.find(params[:id])
        games = team.player_stats.select{|stat| stat.game.season == params[:season].to_i}
        # byebug
        roster = games.map{|stat| stat.player}.uniq
        render json: roster
    end

end
