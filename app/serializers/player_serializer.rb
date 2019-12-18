class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :public_id, :first_name, :last_name, :position, :height_feet, :height_inches, :weight_pounds, :team
end
