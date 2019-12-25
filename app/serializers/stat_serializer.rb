class StatSerializer < ActiveModel::Serializer
  attributes :id, :player, :season, :fgm, :fga, :fg3m, :fg3a, :ftm, :fta, :oreb, :dreb, :reb, :ast, :stl, :blk, :turnover, :pf, :pts, :gp
end
