require_relative( "models/team" )
require_relative( "models/match" )

class League

  attr_reader( :teams, :matches )

  def initialize()
    @teams = Team.all
    @matches = Match.all
  end

  def find_match_result(match)
    home_team_score = match.home_team_score
    away_team_score = match.away_team_score
    match_result = [home_team_score, away_team_score]
    return match_result
  end

  def get_total_points(team)
    scores = []
    for match in team.matches
      case team.id
      when match.home_team_id
        scores.push(match.home_team_score) 
      when match.away_team_id
        scores.push(match.away_team_score)
      end
    end
    total_points = scores.inject(:+)
    return total_points
  end

  def matches_played(team)
    return team.matches.count
  end

  def create_match_report(match)
    match_report = {}
    teams = match.teams
    for team in teams
      case team.id
      when match.home_team_id
        match_report[:home_team_name] = team.name
        match_report[:home_team_score] = match.home_team_score
      when match.away_team_id
        match_report[:away_team_name] = team.name
        match_report[:away_team_score] = match.away_team_score
      end
    end
    return match_report
  end

  def matches_data(team)
    played_matches_data = {}

    num_matches_won = 0
    num_matches_lost = 0
    num_matches_drawn = 0
    for match in team.matches
      match_result = find_match_result(match)
      num_matches_won += 1 if 
      team.id == match.home_team_id && match_result[0] > match_result[1] || 
      team.id == match.away_team_id && match_result[1] > match_result[0]

      num_matches_lost += 1 if 
      team.id == match.home_team_id && match_result[0] < match_result[1] || 
      team.id == match.away_team_id && match_result[1] < match_result[0]

      num_matches_drawn += 1 if 
      team.id == match.home_team_id && match_result[0] == match_result[1] || 
      team.id == match.away_team_id && match_result[1] == match_result[0] 
    end

    played_matches_data = {
      team_name: team.name,
      matches_won: num_matches_won,
      matches_lost: num_matches_lost,
      matches_drawn: num_matches_drawn
    }

    return played_matches_data
  end

  def create_league_table()
    league_table = {}
    @teams.each { |team| league_table[team.name] = {
      total_points: get_total_points(team),
      matches_won: matches_data(team)[:matches_won],
      matches_lost: matches_data(team)[:matches_lost],
      matches_drawn: matches_data(team)[:matches_drawn],
      } }
    return league_table
  end

end