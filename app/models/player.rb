class Player < ApplicationRecord
    self.table_name = 'players'
    has_many :player_stats, class_name: "PlayerStat"
    belongs_to :team, class_name: "Team", foreign_key: "team_id"
end
