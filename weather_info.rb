# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

# Fetches the current temperature of a place from OpenWeatherMap API
class WeatherAPI
  API_URL = 'https://api.openweathermap.org/data/2.5/weather'
  API_KEY = '7fa5c893c0db21360355a74e9d4829fc'

  def self.get_temperature(place)
    puts '0 c'
  end
end

print 'Enter the name of the place: '
place = gets.chomp.downcase
WeatherAPI.get_temperature(place)

