class Season < ApplicationRecord
  belongs_to :team
  has_many :stats
  has_many :players, through: :stats
end
