class Season < ApplicationRecord
  belongs_to :team
  has_many :stats
  has_many :players, through: :stats

  def sim_stats
    roster = self.stats.sort_by{|stat| stat.gp}.reverse[0..11]
    sim = roster.map do |stat|
      {
        "player": stat.player,
        "sim": stat.sd
      }
    end
  end

end

