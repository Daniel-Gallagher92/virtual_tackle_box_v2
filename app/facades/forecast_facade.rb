require "time"

class ForecastFacade 
  def self.get_forecast(location)
    location = MapquestService.new.get_location(location)
    lat = location[:results][0][:locations][0][:latLng][:lat]
    lon = location[:results][0][:locations][0][:latLng][:lng]

    forecast = WeatherService.new.get_forecast(lat, lon)
    current_weather = current_weather(forecast)
    daily_weather = daily_weather(forecast)
    hourly_weather = hourly_weather(forecast)

    Forecast.new(current_weather, daily_weather, hourly_weather)
  end


  private

  def self.current_weather(forecast) 
    {
      last_updated: forecast[:current][:last_updated],
      temp_f: forecast[:current][:temp_f],
      feelslike_f: forecast[:current][:feelslike_f],
      humidity: forecast[:current][:humidity],
      uv: forecast[:current][:uv],
      visibilty: forecast[:current][:vis_miles],
      condition_text: forecast[:current][:condition][:text],
      condition_icon: forecast[:current][:condition][:icon]
    }
  end

  def self.daily_weather(forecast) 
    forecast[:forecast][:forecastday].map do |day| 
      {
        date: day[:date],
        max_temp_f: day[:day][:maxtemp_f],
        min_temp_f: day[:day][:mintemp_f],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        condition_text: day[:day][:condition][:text],
        condition_icon: day[:day][:condition][:icon]
      }
    end
  end

  def self.hourly_weather(forecast) 
    forecast[:forecast][:forecastday].first[:hour].map do |hour| 
      {
        time: Time.parse(hour[:time]).strftime("%H:%M"),
        temp_f: hour[:temp_f],
        condition_text: hour[:condition][:text],
        condition_icon: hour[:condition][:icon]
      }
    end
  end
end