require 'rubystats/normal_distribution'
require 'ruby_native_statistics'

class Stat < ApplicationRecord
  belongs_to :season
  belongs_to :player

  def sim_stat(total, gp, arr)
    if arr.length <= 1 || total == 0
      return 0
    else
      stat_nd = Rubystats::NormalDistribution.new(total/gp, arr.stdevp)
      stat_sim = stat_nd.rng.round
      if stat_sim < 0
        stat_sim = 0
      end
      return stat_sim
    end
  end

  def sd
    fgm = []
    fg2a = []
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
      # if s.fgm
      #   fgm << s.fgm
      # end
      if s.fga
        # byebug
        if s.fg3a
          fg2a << s.fga - s.fg3a
        else
          fg2a << s.fga
        end
      end
      # if s.fg3m
      #   fg3m << s.fg3m
      # end
      if s.fg3a
        fg3a << s.fg3a
      end
      # if s.ftm
      #   ftm << s.ftm
      # end
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
   
    # fgm_sim = sim_stat(self.fgm, self.gp, fgm)
    # fg3m_sim = sim_stat(self.fg3m, self.gp, fg3m)
    # ftm_sim = sim_stat(self.ftm, self.gp, ftm)
    fg2a_sim = sim_stat((self.fga - self.fg3a), self.gp, fg2a)
    fg3a_sim = sim_stat(self.fg3a, self.gp, fg3a)
    fta_sim = sim_stat(self.fta, self.gp, fta)
    oreb_sim = sim_stat(self.oreb, self.gp, oreb)
    dreb_sim = sim_stat(self.dreb, self.gp, dreb)
    ast_sim = sim_stat(self.ast, self.gp, ast)
    stl_sim = sim_stat(self.stl, self.gp, stl)
    blk_sim = sim_stat(self.blk, self.gp, blk)
    to_sim = sim_stat(self.turnover, self.gp, turnover)

    # fg2a_sim = fga_sim - fg3a_sim
    
    fg2_percentage = ((self.fgm.to_f - self.fg3m)/(self.fga - self.fg3a)).round(3)
    fg3_percentage = (self.fg3m.to_f/self.fg3a).round(3)
    ft_percentage = (self.ftm.to_f/self.fta).round(3)
    
    # For 3PA, use a random number generator for EVERY ATTEMPT, to see if shot attempt was successful (using 3P PERCENTAGE)
    # Subtract 3PA from FGA, result will be 2PA. Use same random num generator for EVERY 2-P ATTEMPT, to see if shot attempt was successful (using 2P PERCENTAGE)
    # For 2P PERCENTAGE, subtact FG3A from FGA and FG3M from FGM, using totals to determine 2P PERCENTAGE
    # For FTA, use a random number generator for EVERY ATTEMPT (using FT PERCENTAGE)

    fg3m_sim = 0
    fg2m_sim = 0
    ftm_sim = 0

    fg3a_sim.times do 
      if rand(1..1000) <= (fg3_percentage) * 1000 
        fg3m_sim += 1
      end
    end

    fg2a_sim.times do
      if rand(1..1000) <= (fg2_percentage) * 1000 
        fg2m_sim += 1
      end
    end

    fta_sim.times do
      if rand(1..1000) <= (ft_percentage) * 1000
        ftm_sim += 1
      end
    end

    # fgm_sim = fg2m_sim + fg3m_sim

    # p "FGA: #{fga_sim}"
    # p "FGM: #{fgm_sim}" 
    # p "3PA: #{fg3a_sim}"
    # p "3PM: #{fg3m_sim}"
    # p "FTA: #{fta_sim}"
    # p "FTM: #{ftm_sim}"
    # p "OREB: #{oreb_sim}"
    # p "DREB: #{dreb_sim}"
    # p "STL: #{stl_sim}"
    # p "BLK: #{blk_sim}"
    # p "AST: #{ast_sim}"
    # p "TO: #{to_sim}"

    simulated_stat = 
    {
      "fg2m": fg2m_sim,
      "fg2a": fg2a_sim,
      "fg3m": fg3m_sim,
      "fg3a": fg3a_sim,
      "ftm": ftm_sim,
      "fta": fta_sim,
      "oreb": oreb_sim,
      "dreb": dreb_sim,
      "stl": stl_sim,
      "blk": blk_sim,
      "ast": ast_sim,
      'to': to_sim
    }
  end
  
  # A/40:Assists Per 40 Minutes.
  # AST:The percentage of a team's possessions that ends in an assist. Assist Ratio = (Assists x 100) divided by [(FGA + (FTA x 0.44) + Assists + Turnovers].
  # P/40:Points Per 40 Minutes.
  # PER:A numerical value for each of a player's accomplishments per-minute and is pace-adjusted for the team they play on. The league average in PER to 15.00 every season.
  # R/40:Rebounds Per 40 Minutes.
  # REBR:The percentage of missed shots that a team rebounds. Rebound Rate = (Rebounds x Team Minutes) divided by [Player Minutes x (Team Rebounds + Opponent Rebounds)]
  # TO:The percentage of a team's possessions that end in a turnover. Turnover Ratio = (Turnover x 100) divided by [(FGA + (FTA x 0.44) + Assists + Turnovers].
  # TS%:What a team's shooting percentage would be if we accounted for free throws and 3-pointers. True Shooting Percentage = (Total points x 50) divided by [(FGA + (FTA x 0.44)].
  # USG:the number of possessions a player uses per 40 minutes. Usage Rate = {[FGA + (FT Att. x 0.44) + (Ast x 0.33) + TO] x 40 x League Pace} divided by (Minutes x Team Pace)
  
  # AST RATE
  # TO RATE
  # TRUE SHOOTING PERCENTAGE 
end
