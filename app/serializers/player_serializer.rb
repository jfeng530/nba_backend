class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :public_id, :first_name, :last_name, :full_name, :position, :height_feet, :height_inches, :weight_pounds, :team

  def full_name
    "#{self.object.first_name} #{self.object.last_name}"
  end
  
end
