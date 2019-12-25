require 'rubystats/normal_distribution'
require 'ruby_native_statistics'

class Stat < ApplicationRecord
  belongs_to :season
  belongs_to :player

  def sd
    fgm = []
    fga = []
    fg3m = []
    fg3a = []
    ftm = []
    fta = []
    oreb = []
    dreb = []
    reb = []
    ast = []
    stl = []
    blk = []
    turnover = []
    games = self.player.player_stats.select{|s| s.game.year == self.season.year && s.game.postseason == false}
    games.each do |s|
      if s.fgm
        fgm << s.fgm
      end
      if s.fga
        fga << s.fga
      end
      if s.fg3m
        fg3m << s.fg3m
      end
      if s.fg3a 
        fg3a << s.fg3a
      end
      if s.ftm
        ftm << s.ftm
      end
      if s.fta
        fta << s.fta
      end
      if s.oreb
        oreb << s.oreb
      end
      if s.dreb 
        dreb << s.dreb
      end
      if s.reb
        reb << s.reb
      end
      if s.ast
        ast << s.ast
      end
      if s.stl
        stl << s.stl
      end
      if s.blk 
        blk << s.blk
      end 
      if s.turnover
        turnover << s.turnover
      end
    end
    fgm_nd = Rubystats::NormalDistribution.new(self.fgm/self.gp, fgm.stdevp)
    puts fgm_nd.rng
    # fga_nd = Rubystats::NormalDistribution.new(self.fga/self.gp, fga.stdevp)
    # puts fga_nd.rng
    fg3m_nd = Rubystats::NormalDistribution.new(self.fg3m/self.gp, fg3m.stdevp)
    puts fg3m_nd.rng
    # fg3a_nd = Rubystats::NormalDistribution.new(self.fg3a/self.gp, fg3a.stdevp)
    # puts fg3a_nd.rng
    ftm_nd = Rubystats::NormalDistribution.new(self.ftm/self.gp, ftm.stdevp)
    puts ftm_nd.rng
    # pts_sd = pts.stdevp
    # reb_sd = reb.stdevp
    # fgm_sd = fgm.stdevp
    # fga_sd = fga.stdevp
    # fg3m_sd = fg3m.stdevp
    # fg3a_sd = fg3a.stdevp
    # ftm_sd = ftm.stdevp
    # fta_sd = fta.stdevp
    # oreb_sd = oreb.stdevp
    # dreb_sd = dreb.stdevp
    # reb_sd = reb.stdevp
    # ast_sd = ast.stdevp
    # stl_sd = stl.stdevp
    # blk_sd = blk.stdevp
    # turnover_sd = turnover.stdevp
    # pf_sd = pf.stdevp
  end
  
end
