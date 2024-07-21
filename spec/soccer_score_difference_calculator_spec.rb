
require 'rspec'
require_relative '../soccer_score_diference_calculator'

RSpec.describe SoccerScoreDifferenceCalculator, type: :module do
  before do
    @soccer_file_content = [
      "\n",
      "\n",
      "\n",
      "01 Arsenal 1 2 0 0 4 - 1 1\n",
      "02 Liverpool 0 1 0 0 7 - 2 1\n",
      "03 Manchester 0 1 0 0 3 - 2 1\n",
      "----------------------\n",
      "04 Chelsea 0 0 0 0 2 - 0 1\n",
      "\n"
    ]

    allow(File)
      .to receive(:readlines)
      .with(SoccerScoreDifferenceCalculator::FILEPATH)
      .and_return(@soccer_file_content)
  end

  describe '.soccer_data' do
    it 'returns the contents of the file' do
      expected_content = @soccer_file_content
      expect(SoccerScoreDifferenceCalculator.soccer_data).to eq(expected_content)
    end
  end

  describe '.team_data' do
    it 'returns the team data excluding the first and last rows' do
      expected_soccer_data = [
        "01 Arsenal 1 2 0 0 4 - 1 1\n",
        "02 Liverpool 0 1 0 0 7 - 2 1\n",
        "03 Manchester 0 1 0 0 3 - 2 1\n",
        "----------------------\n",
        "04 Chelsea 0 0 0 0 2 - 0 1\n",
      ]
      expect(SoccerScoreDifferenceCalculator.team_data).to eq(expected_soccer_data)
    end
  end

  describe '.goals_difference' do
    it 'calculates the goals difference for each team' do
      expected_differences = {
        Arsenal: 3,
        Liverpool: 5,
        Manchester: 1,
        Chelsea: 2
      }
      expect(SoccerScoreDifferenceCalculator.goals_difference).to eq(expected_differences)
    end
  end

  describe '.valid_row' do
    context 'with a row with 10 fields' do
      it 'returns true as it is valud ' do
        expect(SoccerScoreDifferenceCalculator.valid_row('01 Arsenal 1 2 0 0 4 - 1 1')).to be_truthy
      end
    end
    context 'with a row of less than 10 fields' do
      it 'returns false for a row with less than 10 fields' do
        expect(SoccerScoreDifferenceCalculator.valid_row("--------------------")).to be_falsey
      end
    end
  end

  describe '.calculate_goals_difference' do
    it 'calculates the difference betweenfor_goals and against_goals' do
      team_row = ['01', 'Arsenal', '1', '2', '0', '0', '4', '1', '1', '1']
      expected_goal_difference = 3
      expect(SoccerScoreDifferenceCalculator.calculate_goals_difference(team_row)).to eq(expected_goal_difference)
    end
  end

  describe '.smallest_score_difference_team' do
    it 'returns the name of the team with the smallest score difference as a string' do
      expect(SoccerScoreDifferenceCalculator.smallest_score_difference_team).to eq('Manchester')
    end
  end
end
