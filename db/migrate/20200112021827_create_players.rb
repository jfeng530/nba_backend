class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.string :position, limit: 10, null: false
      t.integer :height_feet
      t.integer :height_inches
      t.integer :weight_pounds
      t.integer :team_id, null: false
      t.datetime "updated_at", default: -> { "now()" }, null: false
      t.datetime "created_at", default: -> { "now()" }, null: false
      t.serial "public_id", null: false
      t.index ["public_id"], name: "idx_players_id"
    end
  end
end
