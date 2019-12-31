require 'rest-client'

# url = "https://www.balldontlie.io/api/v1"
# team_games_from_specific_season_url = "#{url}/games/?seasons[]=2018&team_ids[]=14"
# all_games_from_specific_player_in_specific_season_url = "#{url}/stats/?per_page=100&seasons[]=2018&player_ids[]=237&postseason=false"

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
#     years = (1979..2019).to_a
#     years.each do |year|
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

# def createStat(arr, player, season)
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
#     arr.each do |game|
#         ast += game["ast"] if game["ast"]
#         blk += game["blk"] if game["blk"]
#         dreb += game["dreb"] if game["dreb"]
#         fg3a += game["fg3a"] if game["fg3a"]
#         fg3m += game["fg3m"] if game["fg3m"]
#         fga += game["fga"] if game["fga"]
#         fgm += game["fgm"] if game["fgm"]
#         ftm += game["ftm"] if game["ftm"]
#         fta += game["fta"] if game["fta"]
#         oreb += game["oreb"] if game["oreb"]
#         pf += game["pf"] if game["pf"]
#         pts += game["pts"] if game["pts"]
#         reb += game["reb"] if game["reb"]
#         stl += game["stl"] if game["stl"]
#         turnover += game["turnover"] if game["turnover"]
#     end
#     Stat.create(player: player, season: season, ast: ast, blk: blk, dreb: dreb, fg3a: fg3a, fg3m: fg3m, fga: fga, fgm: fgm, fta: fta, ftm: ftm, oreb: oreb, pf: pf, pts: pts, reb: reb, stl: stl, turnover: turnover)
# end

# Player.all.each do |player|
#     puts(player.first_name + " " + player.last_name)
#     years = player.player_stats.map{|stat| stat.game.year}.uniq
#     years.each do |year|
#         puts(year)
#         specific_year_stats = player.player_stats.select {|stat| stat.game.year == year && stat.game.postseason == false}
#         teams = specific_year_stats.map{|stat| stat.team}.uniq 
#         teams.each do |team|
#             team_games = specific_year_stats.select { |stat| stat.team == team }
#             season = Season.find_by({team: team, year: year})
#             createStat(team_games, player, season)
#         end
#     end
# end

# ADD GAMES PLAYED TO 'STAT'
# ---------------------------
# ---------------------------

# lebron = Player.find_by({first_name: "LeBron"})
# arr = [lebron]
# games = lebron.games.where(year: 2016, postseason: false).count

# arr = Player.all.sort_by{|p| p.last_name}
# count = 0

# arr.each do |player|
#   count += 1
#   puts(player.first_name + " " + player.last_name)
#   puts("Count: #{count}")
#   player.stats.each do |stat|
#     puts(stat.season.year)
#     games = player.player_stats.select{|s| s.game.year == stat.season.year && s.game.postseason == false}
#     teams = games.map{|s| s.team}.uniq
#     teams.each do |team|
#       num = games.select{|s| s.team == team}.count
#       puts(num)
#       stat.update(gp: num)
#     end
#   end
# end


# NEED TO SAVE GAMES PLAYED FOR SEASON
# --------------------------------------
# --------------------------------------
# --------------------------------------
# arr = Player.all.sort_by{|player| player.last_name}

# arr.each do |player|
#     puts(player.first_name + " " + player.last_name)
#     years = player.stats.map{ |stat| stat.season.year }.uniq
#     years.each do |year|
#         puts(year)
#         season_stats = player.player_stats.select{}
#     end
# end

# Harrison Barnes Test
# ------------------------
# barnes = Player.find(208)
# barnes_season = barnes.player_stats.select {|stat| stat.game.year == 1996 && stat.game.postseason == false}
# teams = barnes_season.map{|stat| stat.team}.uniq
# teams.each do |team|
#     # byebug
#     team_games = barnes_season.select {|stat| stat.team == team && stat.game.postseason == false}
#     season = Season.find_by({team: team, year: 1996})
#     createStat(team_games, barnes, season)
# end

# Adding Full Names to all Players
# ----------------------------------

# Player.all.each do |player|
#     puts(player.first_name + " " + player.last_name)
#     player.full_name = "#{player.first_name} #{player.last_name}"
# end

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

hawks = Team.find_by({name: "Hawks"})
hawks.update(logo: "http://content.sportslogos.net/logos/6/220/full/9168_atlanta_hawks-primary-2016.png")
nets = Team.find_by({name: "Nets"})
nets.update(logo: 'http://content.sportslogos.net/logos/6/3786/full/137_brooklyn-nets-primary-2013.png')
hornets = Team.find_by({name: "Hornets"})
hornets.update(logo: "http://content.sportslogos.net/logos/6/5120/full/1926_charlotte__hornets_-primary-2015.png")
bulls = Team.find_by({name: "Bulls"})
bulls.update(logo: "http://content.sportslogos.net/logos/6/221/full/hj3gmh82w9hffmeh3fjm5h874.png")
cavs = Team.find_by({name: "Cavaliers"})
cavs.update(logo: "http://content.sportslogos.net/logos/6/222/full/6921_cleveland_cavaliers-primary-2018.png")
mavs = Team.find_by({name: "Mavericks"})
mavs.update(logo: "http://content.sportslogos.net/logos/6/228/full/3463_dallas_mavericks-primary-2018.png")
nuggets = Team.find_by({name: "Nuggets"})
nuggets.update(logo: "http://content.sportslogos.net/logos/6/229/full/8926_denver_nuggets-primary-2019.png")
pistons = Team.find_by({name: "Pistons"})
pistons.update(logo: "http://content.sportslogos.net/logos/6/223/full/2164_detroit_pistons-primary-2018.png")
gs = Team.find_by({name: "Warriors"})
gs.update(logo: "http://content.sportslogos.net/logos/6/235/full/3152_golden_state_warriors-primary-2020.png")
rockets = Team.find_by({name: "Rockets"})
rockets.update(logo: "http://content.sportslogos.net/logos/6/230/full/8xe4813lzybfhfl14axgzzqeq.gif")
pacers = Team.find_by({name: "Pacers"})
pacers.update(logo: "http://content.sportslogos.net/logos/6/224/full/4812_indiana_pacers-primary-2018.png")
clippers = Team.find_by({name: "Clippers"})
clippers.update(logo: "http://content.sportslogos.net/logos/6/236/full/5462_los_angeles_clippers-primary-2016.png")
lakers = Team.find_by({name: "Lakers"})
lakers.update(logo: "http://content.sportslogos.net/logos/6/237/full/uig7aiht8jnpl1szbi57zzlsh.png")
grizz = Team.find_by({name: "Grizzlies"})
grizz.update(logo: "http://content.sportslogos.net/logos/6/231/full/4373_memphis_grizzlies-primary-2019.png")
heat = Team.find_by({name: "Heat"})
heat.update(logo: "http://content.sportslogos.net/logos/6/214/full/burm5gh2wvjti3xhei5h16k8e.gif")
bucks = Team.find_by({name: "Bucks"})
bucks.update(logo: "http://content.sportslogos.net/logos/6/225/full/8275_milwaukee_bucks-primary-2016.png")
tims = Team.find_by({name: "Timberwolves"})
tims.update(logo: "http://content.sportslogos.net/logos/6/232/full/9669_minnesota_timberwolves-primary-2018.png")
pelicans = Team.find_by({name: "Pelicans"})
pelicans.update(logo: "http://content.sportslogos.net/logos/6/4962/full/2681_new_orleans_pelicans-primary-2014.png")
knicks = Team.find_by({name: "Knicks"})
knicks.update(logo: "http://content.sportslogos.net/logos/6/216/full/2nn48xofg0hms8k326cqdmuis.gif")
okc = Team.find_by({name: "Thunder"})
okc.update(logo: "http://content.sportslogos.net/logos/6/2687/full/khmovcnezy06c3nm05ccn0oj2.png")
magic = Team.find_by({name: "Magic"})
magic.update(logo: "http://content.sportslogos.net/logos/6/217/full/wd9ic7qafgfb0yxs7tem7n5g4.gif")
philly = Team.find_by({name: "76ers"})
philly.update(logo: "http://content.sportslogos.net/logos/6/218/full/7034_philadelphia_76ers-primary-2016.png")
suns = Team.find_by({name: "Suns"})
suns.update(logo: "http://content.sportslogos.net/logos/6/238/full/4370_phoenix_suns-primary-2014.png")
tb = Team.find_by({name: "Trail Blazers"})
tb.update(logo: "http://content.sportslogos.net/logos/6/239/full/9725_portland_trail_blazers-primary-2018.png")
kings = Team.find_by({name: "Kings"})
kings.update(logo: "http://content.sportslogos.net/logos/6/240/full/4043_sacramento_kings-primary-2017.png")
spurs = Team.find_by({name: "Spurs"})
spurs.update(logo: "http://content.sportslogos.net/logos/6/233/full/2547_san_antonio_spurs-primary-2018.png")
raptors = Team.find_by({name: "Raptors"})
raptors.update(logo: "http://content.sportslogos.net/logos/6/227/full/4578_toronto_raptors-primary-2016.png")
jazz = Team.find_by({name: "Jazz"})
jazz.update(logo: "http://content.sportslogos.net/logos/6/234/full/6749_utah_jazz-primary-2017.png")
wash = Team.find_by({name: "Wizards"})
wash.update(logo: "http://content.sportslogos.net/logos/6/219/full/5671_washington_wizards-primary-2016.png")
boston = Team.find_by({name: "Celtics"})
boston.update(logo: "http://content.sportslogos.net/logos/6/213/full/slhg02hbef3j1ov4lsnwyol5o.png")



puts('Seeded')