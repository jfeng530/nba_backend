class Game < ApplicationRecord
    self.table_name = 'games'
    # self ref with home/away teams
    belongs_to :home_team, class_name: 'Team', foreign_key: "home_team_id"
    belongs_to :away_team, class_name: 'Team', foreign_key: "visitor_team_id"
end
