class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.belongs_to :team, null: false, foreign_key: true
      t.integer :year

      t.timestamps
    end
  end
end
