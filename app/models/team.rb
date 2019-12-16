class Team < ApplicationRecord

    has_many :player_stats
    has_many :seasons
    has_many :games
    has_many :stats, through: :seasons

    has_many :games_as_home, class_name: "Game", foreign_key: "home_team_id"
    has_many :away_opponents, through: :games_as_home, source: :away_team

    has_many :games_as_away, class_name: "Game", foreign_key: "visitor_team_id"
    has_many :home_opponents, through: :games_as_away, source: :home_team

end
