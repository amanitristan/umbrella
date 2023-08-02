pp "Howdy"

# STEP 1: Ask for user's location and store as user_location.
pp "Where are you located?"

user_location = gets.chomp

pp user_location

# STEP 2: Turn the user_location into latitude and longitude using the Google Maps and GMAPS API.

maps_url = " https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

# To test if this variable works dynamically, pp maps_url and enter a location. The program should return the url with the user's location input.
#pp maps_url

require "http"

resp = HTTP.get(maps_url)

pp resp.to_s

parsed_response = JSON.parse(raw_response)

pp parsed_response.fetch("results")

first_results = results.at(0)

geo = first_results.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("location")



=begin COPIED FROM CLASS LESSON IN CANVAS

# I've already created a string variable above: pirate_weather_api_key
# It contains sensitive credentials that hackers would love to steal so it is hidden for security reasons.

require "http"

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# Assemble the full URL string by adding the first part, the API token, and the last part together
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

require "json"

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."

=end
