class PlayerStatSerializer < ActiveModel::Serializer
    attributes :id, :game, :team, :player, :min, :fgm, :fga, :fg3m, :fg3a, :ftm, :fta, :oreb, :dreb, :reb, :ast, :stl, :blk, :turnover, :pf, :pts, :fg_pct, :fg3_pct, :ft_pct
end