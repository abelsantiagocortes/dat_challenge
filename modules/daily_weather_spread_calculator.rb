
module DailyWeatherSpreadCalculator
  FILEPATH = File.join('dat_files', 'weather.dat').freeze

  def self.weather_data
    @weather_data ||= File.readlines(FILEPATH)
  end

  def self.daily_weather_data
    weather_data[6..-3]
  end

  def self.weather_spread
    @weather_spread ||= daily_weather_data.map do |daily_register|
      daily_register = daily_register.split
      calculate_daily_spread(daily_register)
    end
  end

  def self.calculate_daily_spread(daily_register)
    daily_register[1].to_i - daily_register[2].to_i
  end

  def self.smallest_spread
    weather_spread.min
  end

  def self.day_number_with_smallest_spread
    day_index = weather_spread.find_index(smallest_spread)
    day_index ? day_index + 1 : 1
  end
end
