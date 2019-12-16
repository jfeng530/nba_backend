class Season < ApplicationRecord
  belongs_to :team
  has_many :seasons
end
