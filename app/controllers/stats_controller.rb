class StatsController < ApplicationController

    def index
        stats = Stat.all
        render json: stats
    end

    def show
        stat = Stat.find(params[:id])
        render json: stat
    end
    
end
