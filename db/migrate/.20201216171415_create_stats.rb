class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.belongs_to :season, null: false, foreign_key: true
      t.belongs_to :player, null: false, foreign_key: true
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

      t.timestamps
    end
  end
end
