module SoccerScoreDifferenceCalculator
  FILEPATH = File.join('dat_files', 'soccer.dat').freeze

  def self.soccer_data
    @soccer_data ||= File.readlines(FILEPATH)
  end

  def self.team_data
    soccer_data[3..-2]
  end

  def self.goals_difference
    team_data.each_with_object({}) do |team_info, teams_difference|
      next unless invalid_row(team_info)

      team_info = team_info.split
      team_name = team_info[1].to_sym
      teams_difference[team_name] = calculate_goals_difference(team_info)
    end
  end

  def self.invalid_row(team_info)
    team_info.split.size == 10
  end

  def self.calculate_goals_difference(team_info)
    for_goals = team_info[6].to_i
    against_goals = team_info[8].to_i
    (for_goals - against_goals).abs
  end

  def self.smallest_goal_difference
    smallest_difference = goals_difference.values.min
    goals_difference.key(smallest_difference)
  end

  def self.smallest_score_difference_team
    smallest_goal_difference.to_s
  end
end
