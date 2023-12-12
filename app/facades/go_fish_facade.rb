class GoFishFacade 
  def self.get_new_road_trip(origin, destination)
    road_trip = MapquestService.new.get_directions(origin, destination)
    
    if road_trip[:info][:statuscode] == 402
      RoadTrip.new(origin, destination, "impossible route", {})
    else
      lat,lon,travel_time = extract_trip_details(road_trip)
      rounded_time, date, arrival_time, full_time = calculate_times(road_trip)
      
      forecast = fetch_weather(lat,lon,date,full_time)
      
      RoadTrip.new(origin, destination, travel_time, forecast)
    end
  end

  private  

  def self.extract_trip_details(road_trip) 
    lat = road_trip[:route][:locations][1][:latLng][:lat]
    lon = road_trip[:route][:locations][1][:latLng][:lng]
    travel_time = road_trip[:route][:formattedTime]
    [lat, lon, travel_time]
  end

  def self.calculate_times(road_trip) 
    time = Time.now + road_trip[:route][:realTime]
    rounded_time = Time.at((time.to_f / 3600).round * 3600)
    date = time.strftime("%Y-%m-%d")
    arrival_time = rounded_time.strftime("%H:%M")
    full_time = "#{date} #{arrival_time}"
    [rounded_time, date, arrival_time, full_time]
  end

  def self.fetch_weather(lat,lon,date,full_time)
    weather = WeatherService.new.get_forecast(lat, lon)
    weather[:forecast][:forecastday].map do |day|
      if day[:date] == date
        day[:hour].map do |hour|
          if hour[:time] == full_time
            return {
              "datetime": full_time,
              "summary": hour[:condition][:text],
              "icon": hour[:condition][:icon],
              "temperature": hour[:temp_f],
              "feels_like": hour[:feelslike_f],
              "humidity": hour[:humidity],
              "visibility": hour[:vis_miles],
              "uv_index": hour[:uv],
              "wind_speed": hour[:wind_mph],
              "wind_direction": hour[:wind_dir],
              "pressure": hour[:pressure_in],
              "preciptation": hour[:precip_in],
              "cloud_cover": hour[:cloud],
            }
          end
        end
      end
    end
    nil
  end
end