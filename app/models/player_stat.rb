class PlayerStat < ApplicationRecord
    self.table_name = 'player_stats'
    belongs_to :player, class_name: "Player", foreign_key: "player_id"
    belongs_to :game, class_name: "Game", foreign_key: "game_id"
    belongs_to :team, class_name: "Team", foreign_key: "team_id"
end
