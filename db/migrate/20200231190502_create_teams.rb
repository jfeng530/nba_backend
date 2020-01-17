class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :conference, limit: 4, null: false
      t.string :division, limit: 20, null: false
      t.text :city, null: false
      t.string :abbreviation, limit: 3, null: false
      t.text :name, null: false
      t.text :full_name, null: false
      t.serial :public_id, null: false
      t.string :logo
      t.index ["public_id"], name: "idx_teams_public_id"
    end
  end
end
