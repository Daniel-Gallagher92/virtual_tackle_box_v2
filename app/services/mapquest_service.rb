class MapquestService 

  def get_directions(start, destination) 
    get_url("/directions/v2/route?from=#{start}&to=#{destination}")
  end

  private

  def conn 
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params[:key] = Rails.application.credentials.MAPQUEST[:api_key]
    end
  end

  def get_url(url) 
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end