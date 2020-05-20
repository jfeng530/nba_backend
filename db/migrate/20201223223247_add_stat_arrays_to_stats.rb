class AddStatArraysToStats < ActiveRecord::Migration[6.0]
  def change
    add_column :stats, :fg2a_arr, :integer, array: true, default: []
    add_column :stats, :fg3a_arr, :integer, array: true, default: []
    add_column :stats, :fta_arr, :integer, array: true, default: []
    add_column :stats, :oreb_arr, :integer, array: true, default: []
    add_column :stats, :dreb_arr, :integer, array: true, default: []
    add_column :stats, :ast_arr, :integer, array: true, default: []
    add_column :stats, :stl_arr, :integer, array: true, default: []
    add_column :stats, :blk_arr, :integer, array: true, default: []
    add_column :stats, :turnover_arr, :integer, array: true, default: []
  end
end
