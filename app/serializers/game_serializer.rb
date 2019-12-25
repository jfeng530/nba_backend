class GameSerializer < ActiveModel::Serializer
    attributes :id, :date, :home_team_id, :visitor_team_id, :year, :status, :period, :time, :postseason
end