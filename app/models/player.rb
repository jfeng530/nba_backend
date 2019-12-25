class Player < ApplicationRecord
    self.table_name = 'players'
    has_many :stats
    has_many :seasons, through: :stats
    has_many :player_stats, class_name: "PlayerStat"
    has_many :games, through: :player_stats
    belongs_to :team, class_name: "Team", foreign_key: "team_id"

    def show_stats
        season_stats = self.stats.map do |stat|
            {
                "id": stat.id,
                "player": self,
                "season": {
                    "id": stat.season.id,
                    "team": stat.season.team,
                    "year": stat.season.year,
                },
                "fgm": stat.fgm,
                "fga": stat.fga,
                "fg3m": stat.fg3m,
                "fg3a": stat.fg3a,
                "ftm": stat.ftm,
                "fta": stat.fta,
                "oreb": stat.oreb,
                "dreb": stat.dreb,
                "reb": stat.reb,
                "ast": stat.ast,
                "stl": stat.stl,
                "blk": stat.blk,
                "turnover": stat.turnover,
                "pf": stat.pf,
                "pts": stat.pts,
                "gp": stat.gp
            }
        end
    end

end
