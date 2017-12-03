class LeagueTable

  def initialize
    @table = {}
  end

  def push(match)
    home_team_name, home_team_goals, _h, away_team_goals, away_team_name = match.split
    home_team_name.to_sym
    away_team_name.to_sym
    home_team_result = get_game_result(home_team_goals, away_team_goals)
    away_team_result = get_game_result(away_team_goals, home_team_goals)
    save_team_data(home_team_name, home_team_goals.to_i, away_team_goals.to_i, home_team_result[:result], home_team_result[:points])
    save_team_data(away_team_name, away_team_goals.to_i, home_team_goals.to_i, away_team_result[:result], away_team_result[:points])
  end

  def get_points(team_name)
    @table[team_name][:points]
  end

  def get_goals_for(team_name)
    @table[team_name][:goals_for]
  end

  def get_goals_against(team_name)
    @table[team_name][:goals_against]
  end

  def get_goal_difference(team_name)
    @table[team_name][:goal_difference]
  end

  def get_wins(team_name)
    @table[team_name][:wins]
  end

  def get_draws(team_name)
    @table[team_name][:draws]
  end

  def get_losses(team_name)
    @table[team_name][:losses]
  end

  private

  def get_game_result(team_1_goals, team_2_goals)
    if team_1_goals > team_2_goals
      { result: :win, points: 3 }
    elsif team_1_goals == team_2_goals
      { result: :draw, points: 1 }
    elsif team_1_goals < team_2_goals
      { result: :loss, points: 0 }
    end 
  end

  def save_team_data(team_name, goals_for, goals_against, result, points)
    team_data = @table.has_key?(team_name) ? @table[team_name] : { points: 0, goals_for: 0, goals_against: 0, wins: 0, draws: 0, losses: 0, goal_difference: 0 }
    team_data[:points] += points
    team_data[:goals_for] += goals_for
    team_data[:goals_against] += goals_against
    case result
    when :win  then team_data[:wins] += 1
    when :draw then team_data[:draws] += 1
    when :loss then team_data[:losses] += 1
    end
    team_data[:goal_difference] += (goals_for - goals_against)
    @table[team_name] = team_data
  end
end

lt = LeagueTable.new
lt.push('Liverpool 3 - 0 ManUnited')
puts "Points for Liverpool: #{lt.get_points('ManUnited')}"
puts "Goals for Liverpool: #{lt.get_goals_for("Liverpool")}" 
puts "Goals agains ManUnited: #{lt.get_goals_against("ManUnited")}"
puts "Goals difference for Liverpool: #{lt.get_goal_difference("ManUnited")}"
puts "Wins for Liverpool: #{lt.get_wins("Liverpool")}"
puts "Draws for Liverpool: #{lt.get_draws("Liverpool")}"
puts "Losses for Liverpool: #{lt.get_losses("Liverpool")}"
lt.push("Liverpool 2 - 1 LondonArsenal")
puts "Points for LondonArsenal: #{lt.get_points("LondonArsenal")}"
puts "Goals for LondonArsenal: #{lt.get_goals_for("LondonArsenal")}" 
puts "Goals agains LondonArsenal: #{lt.get_goals_against("LondonArsenal")}"
puts "Goals difference for LondonArsenal: #{lt.get_goal_difference("LondonArsenal")}"
puts "Wins for LondonArsenal: #{lt.get_wins("LondonArsenal")}"
puts "Draws for LondonArsenal: #{lt.get_draws("LondonArsenal")}"
puts "Losses for LondonArsenal: #{lt.get_losses("LondonArsenal")}"