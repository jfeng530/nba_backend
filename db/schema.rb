# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_31_190501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", id: :integer, default: nil, force: :cascade do |t|
    t.datetime "date", null: false
    t.integer "home_team_id", null: false
    t.integer "visitor_team_id", null: false
    t.integer "year", null: false
    t.serial "public_id", null: false
    t.string "status"
    t.integer "period"
    t.string "time"
    t.boolean "postseason", default: false, null: false
    t.index ["date", "home_team_id", "visitor_team_id"], name: "games_unique_constraint", unique: true
    t.index ["public_id"], name: "idx_games_public_id"
  end

  create_table "knex_migrations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "batch"
    t.datetime "migration_time"
  end

  create_table "knex_migrations_lock", primary_key: "index", id: :serial, force: :cascade do |t|
    t.integer "is_locked"
  end

  create_table "player_stats", id: :serial, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "team_id", null: false
    t.integer "player_id", null: false
    t.text "min"
    t.integer "fgm"
    t.integer "fga"
    t.integer "fg3m"
    t.integer "fg3a"
    t.integer "ftm"
    t.integer "fta"
    t.integer "oreb"
    t.integer "dreb"
    t.integer "reb"
    t.integer "ast"
    t.integer "stl"
    t.integer "blk"
    t.integer "turnover"
    t.integer "pf"
    t.integer "pts"
    t.serial "public_id", null: false
    t.float "fg_pct"
    t.float "fg3_pct"
    t.float "ft_pct"
    t.index ["game_id", "player_id"], name: "player_stats_game_unique", unique: true
    t.index ["public_id"], name: "idx_player_stats_public_id"
  end

  create_table "players", id: :integer, default: nil, force: :cascade do |t|
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.string "position", limit: 10, null: false
    t.integer "height_feet"
    t.integer "height_inches"
    t.integer "weight_pounds"
    t.integer "team_id", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.serial "public_id", null: false
    t.index ["public_id"], name: "idx_players_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_seasons_on_team_id"
  end

  create_table "stats", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.integer "fgm"
    t.integer "fga"
    t.integer "fg3m"
    t.integer "fg3a"
    t.integer "ftm"
    t.integer "fta"
    t.integer "oreb"
    t.integer "dreb"
    t.integer "reb"
    t.integer "ast"
    t.integer "stl"
    t.integer "blk"
    t.integer "turnover"
    t.integer "pf"
    t.integer "pts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "gp"
    t.index ["player_id"], name: "index_stats_on_player_id"
    t.index ["season_id"], name: "index_stats_on_season_id"
  end

  create_table "teams", id: :integer, default: nil, force: :cascade do |t|
    t.string "conference", limit: 4, null: false
    t.string "division", limit: 20, null: false
    t.text "city", null: false
    t.string "abbreviation", limit: 3, null: false
    t.text "name", null: false
    t.text "full_name", null: false
    t.serial "public_id", null: false
    t.string "logo"
    t.index ["public_id"], name: "idx_teams_public_id"
  end

  create_table "updates", id: false, force: :cascade do |t|
    t.datetime "date", null: false
  end

  add_foreign_key "games", "teams", column: "home_team_id", name: "games_home_team_id_fkey"
  add_foreign_key "games", "teams", column: "visitor_team_id", name: "games_visitor_team_id_fkey"
  add_foreign_key "player_stats", "games", name: "player_stats_game_id_fkey"
  add_foreign_key "player_stats", "teams", name: "player_stats_team_id_fkey"
  add_foreign_key "players", "teams", name: "players_team_id_fkey"
  add_foreign_key "seasons", "teams"
  add_foreign_key "stats", "players"
  add_foreign_key "stats", "seasons"
end
