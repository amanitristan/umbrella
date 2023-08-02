pp "Howdy"

# STEP 1: Ask for user's location and store as user_location.
# Because Google does not allow spaces and replaces them with "%20", we will have to add a .gsub to user_location.
pp "Where are you located?"

#user_location = gets.chomp.gsub(" ", "%20")
#pp user_location

# We will temporarily set user_location to "Chicago" in order to work efficiently until program is complete. Once the program is complete, we will comment out this static input and use the dynamic user_location above.
user_location = "Chicago"


# STEP 2: Turn the user_location into latitude and longitude using the Google Maps and GMAPS API.

maps_url = " https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

# To test if this variable works dynamically, pp maps_url and enter a location. The program should return the url with the user's location input.
#pp maps_url


# STEP 3: Pull the information from the maps_url variable, which will be used to create the raw_response variable that the user receives in response.

require "http"

resp = HTTP.get(maps_url)
#pp resp.to_s
raw_response = resp.to_s


# STEP 4: Parse the response to format the information into a Ruby-/programmer-friendly object. This will allow you to get the specific information needed from the body of the raw response.

require "json"

parsed_response = JSON.parse(raw_response)
#pp parsed_response


# STEP 5: Dig through the hash one layer at a time to get the specific information needed - latitude and longitude.
# Assuming you're working with a hash, try using the .keys method to identify the top-level keys you may have to dig through to get your information. --> pp parsed_response.keys
# As you pull out elements to dig toward the information you need, try using to following methods:
  # .class method (to determine the class type of each element)
  # .length method (to determine how many elements are contained within the hash or array)
  # .at()  (to pull out the exact element you want to dig into deeper)

results = parsed_response.fetch("results")
#pp results
#Try results.class or .keys (if it's a hash) or .length

#Pull out the single element contained within the results array, whcich is a hash. (You must parse out the element in order to work with it.)
#Repeat these steps until you get the information you need.
first_results = results.at(0)
#pp first_results

geo = first_results.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")
#done!

# STEP 6: Take the latitude and longitude of the user's location.

# STEP 7: Assemble the correct URL for the Pirate Weather API.

# STEP 8: GET it, parse it, and dig out the current temperature.




=begin 
COPIED FROM CLASS LESSON IN CANVAS

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
