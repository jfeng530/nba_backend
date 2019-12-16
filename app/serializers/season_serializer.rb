class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :year
  has_one :team
end
