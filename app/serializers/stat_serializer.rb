class StatSerializer < ActiveModel::Serializer
  attributes :id
  has_one :season
  has_one :player
end
