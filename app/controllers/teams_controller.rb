class TeamsController < ApplicationController

    def index
        teams = Team.all
        render json: teams
    end

    def show
        team = Team.find(params[:id])
        render json: team
    end

    def season_roster
        team = Team.find(params[:id])
        season = Season.find_by({team: team, year: params[:season].to_i})
        stats = season.stats
        render json: stats
    end

end
