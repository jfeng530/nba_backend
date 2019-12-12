class Season < ApplicationRecord
  belongs_to :year
  belongs_to :team
  has_many :stats
end
