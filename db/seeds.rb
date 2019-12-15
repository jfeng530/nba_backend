# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'

url = "https://www.balldontlie.io/api/v1"
team_games_from_specific_season_url = "#{url}/games/?seasons[]=2018&team_ids[]=14"
all_games_from_specific_player_in_specific_season_url = "#{url}/stats/?per_page=100&seasons[]=2018&player_ids[]=237&postseason=false"

# Creates all Teams
# -------------------

# request = RestClient::Request.execute(
#     method: :get,
#     url: 'https://www.balldontlie.io/api/v1/teams'
# )
# response = JSON.parse(request)
# teams = response["data"]
# teams.map do |team|
#     Team.create(id: team["id"], abbreviation: team["abbreviation"], city: team["city"], conference: team["conference"], division: team["division"], full_name: team["full_name"], name: team["name"])
# end 

# Creates all Years
# ---------------------

# (1979..2019).to_a.each do |year|
#     Year.create(id: year, year: year)
# end

# Create all Players
# --------------------

# Player.destroy_all

# page = 1
# while page < 34 do
#     request = RestClient::Request.execute(
#         method: :get,
#         url: "https://www.balldontlie.io/api/v1/players?per_page=100&page=#{page}"
#     )
#     response = JSON.parse(request)
#     players = response["data"]
#     players.map do |player|
#         Player.create(id: player["id"], first_name: player["first_name"], last_name: player["last_name"], position: player["position"], height_feet: player["height_feet"], height_inches: player["height_inches"], weight_pounds: player["weight_pounds"], active: false)
#     end
#     page += 1 
# end 

# Create All Seasons
# ------------------------

# Team.all.each do |team|
#     Year.all.each do |year|
#         Season.create(team: team, year: year)
#     end
# end

# ------------------------------------------------------------------------------------------------

# map over the first 500 players and for each player map over all 41 years (1979-2019)
# a single fetch will return all the games of a season
#    sort the array of GAME objects, from first game to last game
#       if the data returned is empty, dont do anything and make the next fetch for the next year (of same player)
#       if the data returned exists, iterate through each game while adding up the total to the counter
#           if the next GAME's TEAM_ID does not match the current one, create a PLAYER_STAT instance with the PLAYER.ID and TEAM_SEASON.ID matching the current SEASON.YEAR and TEAM.ID
#           ,then reset the counters and move on to the next GAME
#       when you reach the end of a season, create a PLAYER_STAT instance with the PLAYER.ID and TEAM_SEASON.ID matching the current SEASON.YEAR and TEAM.ID

# ----------------------------------------------------------------------------------------------------------------------------------
# USE HARRISON BARNES AS A TEST SUBJECT OF HIS 2018. NEED TO SAVE THE ENTIRE GAME INSTANCE SOMEHOW AND SEE IF I CAN SORT BY DATE/ID
# Harrison Barnes: id = 30
# I can (both DATE or ID)
# -----------------------------------------------------------------------------------------------------------------------------------

# pts = 0
# ast = 0
# blk = 0
# dreb = 0
# oreb = 0
# reb = 0
# fg3m = 0
# fg3a = 0
# fgm = 0
# fga = 0
# ftm = 0
# fta = 0
# pf = 0
# stl = 0
# turnover = 0
# team_id = 0

def createStat(arr, player_id, team_id, year)
    pts = 0
    ast = 0
    blk = 0
    dreb = 0
    oreb = 0
    reb = 0
    fg3m = 0
    fg3a = 0
    fgm = 0
    fga = 0
    ftm = 0
    fta = 0
    pf = 0
    stl = 0
    turnover = 0
    arr.each do |game|
        ast += game["ast"] if game["ast"]
        blk += game["blk"] if game["blk"]
        dreb += game["dreb"] if game["dreb"]
        fg3a += game["fg3a"] if game["fg3a"]
        fg3m += game["fg3m"] if game["fg3m"]
        fga += game["fga"] if game["fga"]
        ftm += game["ftm"] if game["ftm"]
        fta += game["fta"] if game["fta"]
        oreb += game["oreb"] if game["oreb"]
        pf += game["pf"] if game["pf"]
        pts += game["pts"] if game["pts"]
        reb += game["reb"] if game["reb"]
        stl += game["stl"] if game["stl"]
        turnover += game["turnover"] if game["turnover"]
    end
    Stat.create(player: Player.find(player_id), season: Season.find_by({year: year, team: team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)
    pts = 0
    ast = 0
    blk = 0
    dreb = 0
    oreb = 0
    reb = 0
    fg3m = 0
    fg3a = 0
    fgm = 0
    fga = 0
    ftm = 0
    fta = 0
    pf = 0
    stl = 0
    turnover = 0
    team_id = 0
end

Player.all.each do |player|
    years = []
    player.player_stats.each do |stat|
        if !years.include?(stat.game.season)
            years.push(stat.game.season)
        end
    end
    puts years
    years.each do |year|
        specific_year = player.player_stats.select {|stat| stat.game.season == year}
        teams = []
        specific_year.each do |stat|
            if !teams.include?(stat.team)
                teams.push(stat.team)
            end
        end
        puts teams
        teams.each do |team|
            team_games = specific_year.select { |game| game.team == team }
            # createStat(team_games, player.id, team_id, year.id)
        end
    end
end


# Create All Stats
# -----------------

# first10 = Player.all.limit(10).sort

# 841 at player[129]
# 1025 at player[159]
# 1345 at player[198]
# 1511 at player[220]
# 1728 at player[250]

# next one is [281..]

# Missed
# ----------
# shaq harrison playerArr[198]

# playerArr = Player.all.sort
# playerArr[291..].each do |player| # 3257 total players
#     puts player.first_name + " " + player.last_name
#     Year.all.each do |year| # 41
#         sleep 1
#         request = RestClient::Request.execute(
#             method: :get,
#             url: "https://www.balldontlie.io/api/v1/stats/?per_page=88&seasons[]=#{year.id}&player_ids[]=#{player.id}&postseason=false"
#         )
#         response = JSON.parse(request)
#         games = response["data"]
#         if games != []
#             sorted_games = games.sort_by { |game| game["game"]["id"] }

#             # teams: an array of all teams that the player played for that season
#             arr = sorted_games.map do |game|
#                 game["team"]["id"]
#             end

#             teams = arr.uniq

#             # for every team that the player played for, create a season stat associating player with said team specific year
#             teams.each do |team_id|
#                 team_games = sorted_games.select { |game| game["team"]["id"] == team_id }
#                 createStat(team_games, player.id, team_id, year.id)
#             end
#         end
#     end
# end

# Can check for multiple teams in a season
# ------------------------------------------

# request = RestClient::Request.execute(
#     method: :get,
#     url: "https://www.balldontlie.io/api/v1/stats/?per_page=100&seasons[]=1996&player_ids[]=830&postseason=false" 
# )
# response = JSON.parse(request)
# games = response["data"]
# sorted_games = games.sort_by { |game| game["game"]["id"] }

# puts(sorted_games.count)

# # teams: an array of all teams that the player played for that season
# arr = sorted_games.map do |game|
#     game["team"]["id"]
# end
# teams = arr.uniq

# # for every team that the player played for, create a season stat associating player with said team specific year
# teams.each do |team_id|
#     team_games = sorted_games.select { |game| game["team"]["id"] == team_id }
#     createStat(team_games, 30, team_id, 2018)
# end


# Only works for 2 teams within a season
# ----------------------------------------

# if sorted_games.first["team"]["id"] != sorted_games.last["team"]["id"]
#     first_half = sorted_games.select { |game| game["team"]["id"] == sorted_games.first["team"]["id"] }
#     second_half = sorted_games.select { |game| game["team"]["id"] == sorted_games.last["team"]["id"] }
#     first_half.map do |game|
#         ast += game["ast"] if game["ast"]
#         blk += game["blk"] if game["blk"]
#         dreb += game["dreb"] if game["dreb"]
#         fg3a += game["fg3a"] if game["fg3a"]
#         fg3m += game["fg3m"] if game["fg3m"]
#         fga += game["fga"] if game["fga"]
#         ftm += game["ftm"] if game["ftm"]
#         fta += game["fta"] if game["fta"]
#         oreb += game["oreb"] if game["oreb"]
#         pf += game["pf"] if game["pf"]
#         pts += game["pts"] if game["pts"]
#         reb += game["reb"] if game["reb"]
#         stl += game["stl"] if game["stl"]
#         turnover += game["turnover"] if game["turnover"]
#         team_id = game["team"]["id"]
#     end
#     Stat.create(player: Player.find(30), season: Season.find_by({year: 2018, team:team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)
#     pts = 0
#     ast = 0
#     blk = 0
#     dreb = 0
#     oreb = 0
#     reb = 0
#     fg3m = 0
#     fg3a = 0
#     fgm = 0
#     fga = 0
#     ftm = 0
#     fta = 0
#     pf = 0
#     stl = 0
#     turnover = 0
#     team_id = 0
#     second_half.map do |game|
#         ast += game["ast"] if game["ast"]
#         blk += game["blk"] if game["blk"]
#         dreb += game["dreb"] if game["dreb"]
#         fg3a += game["fg3a"] if game["fg3a"]
#         fg3m += game["fg3m"] if game["fg3m"]
#         fga += game["fga"] if game["fga"]
#         ftm += game["ftm"] if game["ftm"]
#         fta += game["fta"] if game["fta"]
#         oreb += game["oreb"] if game["oreb"]
#         pf += game["pf"] if game["pf"]
#         pts += game["pts"] if game["pts"]
#         reb += game["reb"] if game["reb"]
#         stl += game["stl"] if game["stl"]
#         turnover += game["turnover"] if game["turnover"]
#         team_id = game["team"]["id"]
#     end
#     Stat.create(player: Player.find(30), season: Season.find_by({year: 2018, team:team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)
#     pts = 0
#     ast = 0
#     blk = 0
#     dreb = 0
#     oreb = 0
#     reb = 0
#     fg3m = 0
#     fg3a = 0
#     fgm = 0
#     fga = 0
#     ftm = 0
#     fta = 0
#     pf = 0
#     stl = 0
#     turnover = 0
#     team_id = 0
# else
#     sorted_games.map do |game|
#         ast += game["ast"] if game["ast"]
#         blk += game["blk"] if game["blk"]
#         dreb += game["dreb"] if game["dreb"]
#         fg3a += game["fg3a"] if game["fg3a"]
#         fg3m += game["fg3m"] if game["fg3m"]
#         fga += game["fga"] if game["fga"]
#         ftm += game["ftm"] if game["ftm"]
#         fta += game["fta"] if game["fta"]
#         oreb += game["oreb"] if game["oreb"]
#         pf += game["pf"] if game["pf"]
#         pts += game["pts"] if game["pts"]
#         reb += game["reb"] if game["reb"]
#         stl += game["stl"] if game["stl"]
#         turnover += game["turnover"] if game["turnover"]
#         team_id = game["team"]["id"]
#     end
#     Stat.create(player: Player.find(30), season: Season.find_by({year: 2018, team:team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)
# end



# Checks to see if next game's team matches, doesn't include the last game before a trade
# -----------------------------------------------------------------------------------------

# sorted_games.each_cons(2) do |game, next_game|
#     if game["team"]["id"] == next_game["team"]["id"]
#         pts += game["pts"] if game["pts"]
#         ast += game["ast"] if game["ast"]
#         blk += game["blk"] if game["blk"]
#         oreb += game["oreb"] if game["oreb"]
#         dreb += game["dreb"] if game["dreb"]
#         reb += game["reb"] if game["reb"]
#         fg3m += game["fg3m"] if game["fg3m"]
#         fg3a += game["fg3a"] if game["fg3a"]
#         fgm += game["fgm"] if game["fgm"]
#         fga += game["fga"] if game["fga"]
#         ftm += game["ftm"] if game["ftm"]
#         fta += game["fta"] if game["fta"]
#         pf += game["pf"] if game["pf"]
#         stl += game["stl"] if game["stl"]
#         turnover += game["turnover"] if game["turnover"]
#         team_id = game["team"]["id"]
#     else
#         Stat.create(player: Player.find(30), season: Season.find_by({year: 2018, team:team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)
#         pts = 0
#         ast = 0
#         blk = 0
#         oreb = 0
#         dreb = 0
#         reb = 0
#         fg3m = 0
#         fg3a = 0
#         fgm = 0
#         fga = 0
#         ftm = 0
#         fta = 0
#         pf = 0
#         stl = 0
#         turnover = 0
#         team_id = 0
#     end
# end
# Stat.create(player: Player.find(30), season: Season.find_by({year: 2018, team:team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)












# LeBron 2018 Season Test Case
# ---------------------------------

# request = RestClient::Request.execute(
#     method: :get,
#     url: "https://www.balldontlie.io/api/v1/stats/?per_page=100&seasons[]=2018&player_ids[]=237&postseason=false" 
#     )
#     response = JSON.parse(request)
#     games = response["data"]
#     games.map do |game|
#         ast += game["ast"] if game["ast"]
#         blk += game["blk"] if game["blk"]
#         dreb += game["dreb"] if game["dreb"]
#         fg3a += game["fg3a"] if game["fg3a"]
#         fg3m += game["fg3m"] if game["fg3m"]
#         fga += game["fga"] if game["fga"]
#         ftm += game["ftm"] if game["ftm"]
#         fta += game["fta"] if game["fta"]
#         oreb += game["oreb"] if game["oreb"]
#         pf += game["pf"] if game["pf"]
#         pts += game["pts"] if game["pts"]
#         reb += game["reb"] if game["reb"]
#         stl += game["stl"] if game["stl"]
#         turnover += game["turnover"] if game["turnover"]
#         team_id = game["team"]["id"]
#     end
# Stat.create(player: Player.find(237), season: Season.find_by({year: 2018, team:team_id}), ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)



puts('Seeded')