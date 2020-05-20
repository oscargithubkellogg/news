require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do


  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "metric" # or imperial, whatever you like
  weatherAPIkey = "8b0c482ef95d6d1d071af47a3343e292" # replace this with your real OpenWeather API key
 
  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  weatherurl = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{weatherAPIkey}"

  # make the call
  @forecast = HTTParty.get(weatherurl).parsed_response.to_hash
  
  # pp @forecast

  @current_temperature = @forecast["current"]["temp"]
  @current_weather_descr = @forecast["current"]["weather"][0]["description"]
  
  # Get some useful values: Send the provided lat/long coordinates to the OpenWeather API's "one call" API.
  # Retrieve the result and display the current and forecasted weather (using a for-loop) in a user-friendly format.


  ### Get the news

  # construct the URL to get the API data
  # Use the News API to retrieve the top news headlines. Using a for-loop, display the news and a link to the source article.

  newsAPIkey = "0cc257f79cfa4e8199daa350aa6e5478"

  newsurl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{newsAPIkey}"

  @news = HTTParty.get(newsurl).parsed_response.to_hash
  # news is now a Hash you can pretty print (pp) and parse for your output
  # pp @news

  @first_headline = @news["articles"][0]["title"]
  @first_url = @news["articles"][0]["url"]
  @second_headline = @news["articles"][1]["title"]
  @second_url = @news["articles"][1]["url"]
  @third_headline = @news["articles"][2]["title"]
  @third_url = @news["articles"][2]["url"]

  view "news"

end