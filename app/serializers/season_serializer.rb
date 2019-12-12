class SeasonSerializer < ActiveModel::Serializer
  attributes :id
  has_one :year
  has_one :team
end
