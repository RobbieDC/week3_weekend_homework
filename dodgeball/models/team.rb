require("pg")
require_relative("../db/sql_runner")

class Team

  attr_accessor( :id, :name )

  def initialize( options )
    @id = options["id"].to_i
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO teams (name) VALUES ('#{ @name }') RETURNING *;"
    team = SqlRunner.run( sql ).first
    @id = team["id"].to_i
  end

  def matches()
    sql = "
      SELECT * FROM matches 
      WHERE home_team_id = #{@id} OR away_team_id = #{@id};
    "
    team_matches = SqlRunner.run( sql )
    team_matches_objects = team_matches.map { |match| Match.new(match) }
    return team_matches_objects
  end

  def self.all()
    sql = "SELECT * FROM teams;"
    teams = SqlRunner.run( sql )
    team_objects = teams.map { |team| Team.new(team) }
    return team_objects
  end

  def self.find(id)
    sql = "SELECT * FROM teams WHERE id = #{id};"
    team = SqlRunner.run( sql ).first
    team_object = Team.new( team )
    return team_object
  end

  def self.delete_all()
    sql = "DELETE FROM teams;"
    SqlRunner.run(sql)
    return "Deleted all teams"
  end

end