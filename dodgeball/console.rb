require_relative( "./models/team" )
require_relative( "./models/match" )

require( "pry-byebug" )

Team.delete_all()
Match.delete_all()

team_1 = Team.new( { "name" => "All Dodge No Balls" } )
team_2 = Team.new( { "name" => "Ben Wa Balls" } )
team_3 = Team.new( { "name" => "The Betty Grumballs"} )
team_4 = Team.new( { "name" => "Ballsagna" } )
team_1.save()
team_2.save()
team_3.save()
team_4.save()

match_1 = Match.new( { 
  "home_team_id" => team_1.id, 
  "away_team_id" => team_2.id,
  "home_team_score" => 22,
  "away_team_score" => 31
  } )
match_2 = Match.new( {
  "home_team_id" => team_3.id,
  "away_team_id" => team_4.id,
  "home_team_score" => 36,
  "away_team_score" => 13
  } )
match_3 = Match.new( {
  "home_team_id" => team_4.id,
  "away_team_id" => team_3.id,
  "home_team_score" => 2,
  "away_team_score" => 44
  } )
match_4 = Match.new( {
  "home_team_id" => team_3.id,
  "away_team_id" => team_2.id,
  "home_team_score" => 2,
  "away_team_score" => 80
  } )
match_5 = Match.new( {
  "home_team_id" => team_4.id,
  "away_team_id" => team_2.id,
  "home_team_score" => 25,
  "away_team_score" => 47
  } )
match_6 = Match.new( {
  "home_team_id" => team_4.id,
  "away_team_id" => team_1.id,
  "home_team_score" => 10,
  "away_team_score" => 10
  } )
match_1.save()
match_2.save()
match_3.save()
match_4.save()
match_5.save()
match_6.save()

binding.pry()
nil