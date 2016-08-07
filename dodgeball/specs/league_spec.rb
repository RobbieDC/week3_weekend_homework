require( "minitest/autorun" )
require_relative( "../league" )
require_relative( "../models/team" )
require_relative( "../models/match" )

class TestLeague < MiniTest::Test

  def setup
    @league = League.new()
  end

  def test_league_teams
    team_4 = @league.teams[3]
    assert_equal( "Ballsagna", team_4.name )
  end

  def test_league_matches
    match_2 = @league.matches[1]
    assert_equal( 13, match_2.away_team_score )
  end

  def test_find_match_result
    match_1 = @league.matches[0]
    assert_equal( [22, 31], @league.find_match_result(match_1) )
  end

  def test_get_total_points
    team_3 = @league.teams[2]
    assert_equal( 82, @league.get_total_points(team_3) )
  end

  def test_matches_played
    team_2 = @league.teams[1]
    assert_equal( 3, @league.matches_played(team_2) )
  end

  def test_create_match_report
    match_5 = @league.matches[4]
    assert_equal( {
      away_team_name: "Ben Wa Balls",
      away_team_score: 47,
      home_team_name: "Ballsagna",
      home_team_score: 25
      }, @league.create_match_report(match_5) )
  end

  def test_matches_data
    team_4 = @league.teams[3]
    assert_equal( {
      team_name: "Ballsagna",
      matches_won: 0,
      matches_lost: 3,
      matches_drawn: 1
      }, @league.matches_data(team_4) )
  end

  def test_create_league_table
    assert_equal( {
      "All Dodge No Balls" => {
        total_points: 32, 
        matches_won: 0, 
        matches_lost: 1, 
        matches_drawn: 1
        }, 
      "Ben Wa Balls" => {
        total_points: 158, 
        matches_won: 3, 
        matches_lost: 0, 
        matches_drawn: 0
        }, 
      "The Betty Grumballs" => {
        total_points: 82, 
        matches_won: 2, 
        matches_lost: 1, 
        matches_drawn: 0
        }, 
      "Ballsagna" => {
        total_points: 50, 
        matches_won: 0, 
        matches_lost: 3, 
        matches_drawn: 1
        } }, @league.create_league_table )
  end

end