# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

# Fetches the current temperature of a place from OpenWeatherMap API
class WeatherAPI
  API_URL = 'https://api.openweathermap.org/data/2.5/weather'
  API_KEY = '7fa5c893c0db21360355a74e9d4829fc'

  def self.make_request(place)
    url = URI(API_URL)
    params = {
      appid: API_KEY,
      q: place,
      units: 'metric' # For temperature in celsius unit
    }
    url.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(url)
    return response.read_body
  end

  def self.get_temperature(place)
    data = make_request(place)
    parsed_data = JSON.parse(data)

    puts
    if parsed_data['cod'] != 200
      puts parsed_data['message']
    else
      display_info(parsed_data)
    end
  end

  def self.display_info(json_data)
    name = json_data['name']
    weather = json_data['weather'][0]['main']
    curr_temp = json_data['main']['temp']
    min_temp = json_data['main']['temp_min']
    max_temp = json_data['main']['temp_max']

    puts "#{name} :"
    puts "Weather Like : #{weather}"
    puts "Current Temperature : #{curr_temp} c"
    puts "Max Temperature : #{max_temp} c"
    puts "Min Temperature : #{min_temp} c"
  end
end

print 'Enter the name of the place: '
place = gets.chomp.downcase
WeatherAPI.get_temperature(place)

