require 'rspec'
require_relative '../daily_weather_spread_calculator'

RSpec.describe DailyWeatherSpreadCalculator, type: :module do
  before do
    @weather_file_content = [
      "\n",
      "\n",
      "\n",
      "\n",
      "\n",
      "DAY MAX MIN\n",
      "01 30 25\n",
      "02 28 22\n",
      "03 35 21\n",
      "04 32 30\n",
      "05 30 29\n",
      "\n",
      "\n"
    ]
    allow(File)
      .to receive(:readlines)
      .with(DailyWeatherSpreadCalculator::FILEPATH)
      .and_return(@weather_file_content)
  end

  describe '.weather_data' do
    it 'returns the contents of the file with no formatting' do
      expected_content = @weather_file_content
      expect(DailyWeatherSpreadCalculator.weather_data).to eq(expected_content)
    end
  end

  describe '.daily_weather_data' do
    it 'returns the daily weather data excluding the first and last rows' do
      expected_only_daily_weather_data = [
        "01 30 25\n",
        "02 28 22\n",
        "03 35 21\n",
        "04 32 30\n",
        "05 30 29\n"
      ]
      expect(DailyWeatherSpreadCalculator.daily_weather_data).to eq(expected_only_daily_weather_data)
    end
  end

  describe '.weather_spread' do
    it 'calculates the spread for each day' do
      expected_daily_spreads = [5, 6, 14, 2, 1]
      expect(DailyWeatherSpreadCalculator.weather_spread).to eq(expected_daily_spreads)
    end
  end

  describe '.smallest_spread' do
    it 'returns the smallest spread' do
      expected_smallest_spread = 1
      expect(DailyWeatherSpreadCalculator.smallest_spread).to eq(expected_smallest_spread)
    end
  end

  describe '.day_number_with_smallest_spread' do
    it 'returns the day number with the smallest spread' do
      expected_day_number = 5
      expect(DailyWeatherSpreadCalculator.day_number_with_smallest_spread).to eq(expected_day_number)
    end
  end
end
