class AddGpToStats < ActiveRecord::Migration[6.0]
  def change
    add_column :stats, :gp, :integer
  end
end
