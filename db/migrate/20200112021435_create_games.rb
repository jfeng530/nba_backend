class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.datetime :date, null: false
      t.integer :home_team_id, null: false
      t.integer :visitor_team_id, null: false
      t.integer :year, null: false
      t.serial :public_id, null: false
      t.string :status
      t.integer :period
      t.string :time
      t.boolean :postseason, default: false, null: false
      t.index ["date", "home_team_id", "visitor_team_id"], name: "games_unique_constraint", unique: true
      t.index ["public_id"], name: "idx_games_public_id"
    end
  end
end
