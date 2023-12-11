require "rails_helper"

RSpec.describe WeatherService do 
  describe "instance methods" do 
    describe "#get_forecast" do 
      it "returns current, daily and hourly forecast data for a given location", :vcr do 
        service = WeatherService.new
        data = service.get_forecast(39.738453, -104.984853)

        expect(data).to be_a(Hash)
        expect(data).to have_key(:location)
        expect(data[:location]).to be_a(Hash)
        expect(data[:location]).to have_key(:name)
        expect(data[:location][:name]).to be_a(String)
        expect(data[:location]).to have_key(:region)
        expect(data[:location][:region]).to be_a(String)
        expect(data[:location]).to have_key(:country)
        expect(data[:location][:country]).to be_a(String)
        expect(data[:location]).to have_key(:lat)
        expect(data[:location][:lat]).to be_a(Float)
        expect(data[:location]).to have_key(:lon)
        expect(data[:location][:lon]).to be_a(Float)
        expect(data[:location]).to have_key(:tz_id)
        expect(data[:location][:tz_id]).to be_a(String)
        expect(data[:location]).to have_key(:localtime)
        expect(data[:location][:localtime]).to be_a(String)
        
        #Current weather
        expect(data).to have_key(:current)
        expect(data[:current]).to be_a(Hash)
        expect(data[:current]).to have_key(:last_updated)
        expect(data[:current][:last_updated]).to be_a(String)
        expect(data[:current]).to have_key(:temp_f)
        expect(data[:current][:temp_f]).to be_a(Float)
        expect(data[:current]).to have_key(:temp_c)
        expect(data[:current][:temp_c]).to be_a(Float)

        #nested condition hash w/ icon and text
        expect(data[:current]).to have_key(:condition)
        expect(data[:current][:condition]).to be_a(Hash)
        expect(data[:current][:condition]).to have_key(:text)
        expect(data[:current][:condition][:text]).to be_a(String)
        expect(data[:current][:condition]).to have_key(:icon)
        expect(data[:current][:condition][:icon]).to be_a(String)

        expect(data[:current]).to have_key(:wind_mph)
        expect(data[:current][:wind_mph]).to be_a(Float)
        expect(data[:current]).to have_key(:wind_kph)
        expect(data[:current][:wind_kph]).to be_a(Float)
        expect(data[:current]).to have_key(:wind_mph)
        expect(data[:current][:wind_mph]).to be_a(Float)
        expect(data[:current]).to have_key(:wind_degree)
        expect(data[:current][:wind_degree]).to be_a(Integer)
        expect(data[:current]).to have_key(:wind_dir)
        expect(data[:current][:wind_dir]).to be_a(String)
        expect(data[:current]).to have_key(:pressure_mb)
        expect(data[:current][:pressure_mb]).to be_a(Float)
        expect(data[:current]).to have_key(:pressure_in)
        expect(data[:current][:pressure_in]).to be_a(Float)
        expect(data[:current]).to have_key(:precip_mm)
        expect(data[:current][:precip_mm]).to be_a(Float)
        expect(data[:current]).to have_key(:precip_in)
        expect(data[:current][:precip_in]).to be_a(Float)
        expect(data[:current]).to have_key(:humidity)
        expect(data[:current][:humidity]).to be_a(Integer)
        expect(data[:current]).to have_key(:cloud)
        expect(data[:current][:cloud]).to be_a(Integer)
        expect(data[:current]).to have_key(:feelslike_f)
        expect(data[:current][:feelslike_f]).to be_a(Float)
        expect(data[:current]).to have_key(:feelslike_c)
        expect(data[:current][:feelslike_c]).to be_a(Float)
        expect(data[:current]).to have_key(:vis_km)
        expect(data[:current][:vis_km]).to be_a(Float)
        expect(data[:current]).to have_key(:vis_miles)
        expect(data[:current][:vis_miles]).to be_a(Float)
        expect(data[:current]).to have_key(:uv)
        expect(data[:current][:uv]).to be_a(Float)
        expect(data[:current]).to have_key(:gust_mph)
        expect(data[:current][:gust_mph]).to be_a(Float)
        expect(data[:current]).to have_key(:gust_kph)
        expect(data[:current][:gust_kph]).to be_a(Float)
        
        #Daily forecast array
        expect(data).to have_key(:forecast)
        expect(data[:forecast]).to be_a(Hash)
        expect(data[:forecast]).to have_key(:forecastday)
        forecast_days = data[:forecast][:forecastday]
        expect(forecast_days).to be_an(Array)

        #NOTE: Weather API is only returning 3 days of forecast data,
        # for free tier
        expect(forecast_days.count).to eq(3)

        forecast_days.each do |day| 
          expect(day).to have_key(:date)
          expect(day[:date]).to be_a(String)
          expect(day).to have_key(:day)
          
          day_info = day[:day]

          expect(day_info).to be_a(Hash)

          #max/min/avg temp farenheit/celsius
          expect(day_info).to have_key(:maxtemp_f)
          expect(day_info[:maxtemp_f]).to be_a(Float)
          expect(day_info).to have_key(:maxtemp_c)
          expect(day_info[:maxtemp_c]).to be_a(Float)
          expect(day_info).to have_key(:mintemp_f)
          expect(day_info[:mintemp_f]).to be_a(Float)
          expect(day_info).to have_key(:mintemp_c)
          expect(day_info[:mintemp_c]).to be_a(Float)
          expect(day_info).to have_key(:avgtemp_f)
          expect(day_info[:avgtemp_f]).to be_a(Float)
          expect(day_info).to have_key(:avgtemp_c)
          expect(day_info[:avgtemp_c]).to be_a(Float)

          #wind speed mph/kph
          expect(day_info).to have_key(:maxwind_mph)
          expect(day_info[:maxwind_mph]).to be_a(Float)
          expect(day_info).to have_key(:maxwind_kph)
          expect(day_info[:maxwind_kph]).to be_a(Float)

          #precipitation inches/millimeters
          expect(day_info).to have_key(:totalprecip_in)
          expect(day_info[:totalprecip_in]).to be_a(Float)
          expect(day_info).to have_key(:totalprecip_mm)
          expect(day_info[:totalprecip_mm]).to be_a(Float)
          expect(day_info).to have_key(:totalsnow_cm)
          expect(day_info[:totalsnow_cm]).to be_a(Float)
          
          #visibility miles/kilometers
          expect(day_info).to have_key(:avgvis_miles)
          expect(day_info[:avgvis_miles]).to be_a(Float)
          expect(day_info).to have_key(:avgvis_km)
          expect(day_info[:avgvis_km]).to be_a(Float)
          
          #humidity
          expect(day_info).to have_key(:avghumidity)
          expect(day_info[:avghumidity]).to be_a(Float)
          
          #chances of rain/snow
          expect(day_info).to have_key(:daily_will_it_rain)
          expect(day_info[:daily_will_it_rain]).to be_a(Integer)
          expect(day_info).to have_key(:daily_chance_of_rain)
          expect(day_info[:daily_chance_of_rain]).to be_a(Integer)
          expect(day_info).to have_key(:daily_will_it_snow)
          expect(day_info[:daily_will_it_snow]).to be_a(Integer)
          expect(day_info).to have_key(:daily_chance_of_snow)
          expect(day_info[:daily_chance_of_snow]).to be_a(Integer)
          
          #condition
          expect(day_info).to have_key(:condition)
          expect(day_info[:condition]).to be_a(Hash)
          expect(day_info[:condition]).to have_key(:text)
          expect(day_info[:condition][:text]).to be_a(String)
          expect(day_info[:condition]).to have_key(:icon)
          expect(day_info[:condition][:icon]).to be_a(String)
          expect(day_info[:condition]).to have_key(:code)
          expect(day_info[:condition][:code]).to be_a(Integer)

          #UV index
          expect(day_info).to have_key(:uv)

          #Sunrise/Sunset and other Astro data
          expect(day).to have_key(:astro)
          expect(day[:astro]).to be_a(Hash)
          expect(day[:astro]).to have_key(:sunrise)
          expect(day[:astro][:sunrise]).to be_a(String)
          expect(day[:astro]).to have_key(:sunset)
          expect(day[:astro][:sunset]).to be_a(String)
          expect(day[:astro]).to have_key(:moonrise)
          expect(day[:astro][:moonrise]).to be_a(String)
          expect(day[:astro]).to have_key(:moonset)
          expect(day[:astro][:moonset]).to be_a(String)
          expect(day[:astro]).to have_key(:moon_phase)
          expect(day[:astro][:moon_phase]).to be_a(String)
          expect(day[:astro]).to have_key(:moon_illumination)
          expect(day[:astro][:moon_illumination]).to be_an(Integer)
          expect(day[:astro]).to have_key(:is_moon_up)
          expect(day[:astro][:is_moon_up]).to be_an(Integer)
          expect(day[:astro]).to have_key(:is_sun_up)
          expect(day[:astro][:is_sun_up]).to be_an(Integer)
        end
        
        #Hourly forecast array
        data[:forecast][:forecastday].each do |day| 
          expect(day).to have_key(:hour)
          expect(day[:hour]).to be_an(Array)
          expect(day[:hour].count).to eq(24)

          day[:hour].each do |hour| 
            expect(hour).to have_key(:time)
            expect(hour[:time]).to be_a(String)
            expect(hour).to have_key(:temp_f)
            expect(hour[:temp_f]).to be_a(Float)
            expect(hour).to have_key(:temp_c)
            expect(hour[:temp_c]).to be_a(Float)
            expect(hour).to have_key(:is_day)
            expect(hour[:is_day]).to be_an(Integer)

            #hourly condition hash w/ icon and text
            expect(hour).to have_key(:condition)
            expect(hour[:condition]).to be_a(Hash)
            expect(hour[:condition]).to have_key(:text)
            expect(hour[:condition][:text]).to be_a(String)
            expect(hour[:condition]).to have_key(:icon)
            expect(hour[:condition][:icon]).to be_a(String)
            expect(hour[:condition]).to have_key(:code)
            expect(hour[:condition][:code]).to be_an(Integer)

            expect(hour).to have_key(:wind_mph)
            expect(hour[:wind_mph]).to be_a(Float)
            expect(hour).to have_key(:wind_kph)
            expect(hour[:wind_kph]).to be_a(Float)
            expect(hour).to have_key(:wind_degree)
            expect(hour[:wind_degree]).to be_an(Integer)
            expect(hour).to have_key(:wind_dir)
            expect(hour[:wind_dir]).to be_a(String)
            expect(hour).to have_key(:pressure_mb)
            expect(hour[:pressure_mb]).to be_a(Float)
            expect(hour).to have_key(:pressure_in)
            expect(hour[:pressure_in]).to be_a(Float)

            #precipitation inches/millimeters
            expect(hour).to have_key(:precip_mm)
            expect(hour[:precip_mm]).to be_a(Float)
            expect(hour).to have_key(:precip_in)
            expect(hour[:precip_in]).to be_a(Float)
            
            #humidity
            expect(hour).to have_key(:humidity)
            expect(hour[:humidity]).to be_an(Integer)

            #cloud cover
            expect(hour).to have_key(:cloud)
            expect(hour[:cloud]).to be_an(Integer)

            #feels like temp farenheit/celsius
            expect(hour).to have_key(:feelslike_f)
            expect(hour[:feelslike_f]).to be_a(Float)
            expect(hour).to have_key(:feelslike_c)
            expect(hour[:feelslike_c]).to be_a(Float)
            
            #wind chill temp farenheit/celsius
            expect(hour).to have_key(:windchill_f)
            expect(hour[:windchill_f]).to be_a(Float)
            expect(hour).to have_key(:windchill_c)
            expect(hour[:windchill_c]).to be_a(Float)
            
            #heat index temp farenheit/celsius
            expect(hour).to have_key(:heatindex_f)
            expect(hour[:heatindex_f]).to be_a(Float)
            expect(hour).to have_key(:heatindex_c)
            expect(hour[:heatindex_c]).to be_a(Float)
            
            #dew point temp farenheit/celsius
            expect(hour).to have_key(:dewpoint_f)
            expect(hour[:dewpoint_f]).to be_a(Float)
            expect(hour).to have_key(:dewpoint_c)
            expect(hour[:dewpoint_c]).to be_a(Float)
            
            #wind gust mph/kph
            expect(hour).to have_key(:gust_mph)
            expect(hour[:gust_mph]).to be_a(Float)
            expect(hour).to have_key(:gust_kph)
            expect(hour[:gust_kph]).to be_a(Float)
            
            #UV index
            expect(hour).to have_key(:uv)
            expect(hour[:uv]).to be_a(Float)
          end
        end

      end
    end
  end
end