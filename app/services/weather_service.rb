class WeatherService 

  def get_forecast(lat, lon, additonal_params = {}) 
    get_url("/v1/forecast.json?q=#{lat},#{lon}&days=5") do |f|
      additonal_params.each do |key, value|
        f.params[key] = value
      end
    end
  end
  
  private 

  def conn 
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params[:key] = Rails.application.credentials.WEATHER[:api_key]
    end
  end

  def get_url(url) 
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end