class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :position, :height_feet, :height_inches, :weight_pounds, :active
end
