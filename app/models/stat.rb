require 'rubystats/normal_distribution'
require 'ruby_native_statistics'

class Stat < ApplicationRecord
  belongs_to :season
  belongs_to :player

  def sim_stat(total, gp, arr)
    stat_nd = Rubystats::NormalDistribution.new(total/gp, arr.stdevp)
    stat_sim = stat_nd.rng.round
    if stat_sim < 0
      stat_sim = 0
    end
    return stat_sim
  end

  def sd
    fgm = []
    fga = []
    fg3m = []
    fg3a = []
    ftm = []
    fta = []
    oreb = []
    dreb = []
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
   
    fgm_sim = sim_stat(self.fgm, self.gp, fgm)
    fg3m_sim = sim_stat(self.fg3m, self.gp, fg3m)
    ftm_sim = sim_stat(self.ftm, self.gp, ftm)
    oreb_sim = sim_stat(self.oreb, self.gp, oreb)
    dreb_sim = sim_stat(self.dreb, self.gp, dreb)
    ast_sim = sim_stat(self.ast, self.gp, ast)
    stl_sim = sim_stat(self.stl, self.gp, stl)
    blk_sim = sim_stat(self.blk, self.gp, blk)
    to_sim = sim_stat(self.turnover, self.gp, turnover)
    
  end
  
end
