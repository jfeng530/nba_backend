class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.integer :game_id, null: false
      t.integer :team_id, null: false
      t.integer :player_id, null: false
      t.text :min
      t.integer :fgm
      t.integer :fga
      t.integer :fg3m
      t.integer :fg3a
      t.integer :ftm
      t.integer :fta
      t.integer :oreb
      t.integer :dreb
      t.integer :reb
      t.integer :ast
      t.integer :stl
      t.integer :blk
      t.integer :turnover
      t.integer :pf
      t.integer :pts
      t.serial :public_id, null: false
      t.float :fg_pct
      t.float :fg3_pct
      t.float :ft_pct
      t.index ["game_id", "player_id"], name: "player_stats_game_unique", unique: true
      t.index ["public_id"], name: "idx_player_stats_public_id"
    end
  end
end
