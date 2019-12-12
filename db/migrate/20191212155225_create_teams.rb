class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :abbreviation
      t.string :city
      t.string :conference
      t.string :division
      t.string :full_name
      t.string :name

      t.timestamps
    end
  end
end
