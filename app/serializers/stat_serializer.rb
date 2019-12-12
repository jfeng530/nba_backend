class StatSerializer < ActiveModel::Serializer
  attributes :id, :ast, :blk, :dreb, :fg3a, :fg3m, :fga, :fgm, :fta, :ftm, :oreb, :pf, :pts, :reb, :stl, :to
  has_one :player
  has_one :season
end
