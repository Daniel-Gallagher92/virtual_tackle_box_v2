class RoadTrip 
  attr_reader :id,
              :type,
              :origin,
              :destination,
              :travel_time,
              :forecast

  def initialize(origin, destination, travel_time, forecast)
    @id = "null"
    @type = "roadtrip"
    @origin = origin
    @destination = destination
    @travel_time = travel_time
    @forecast = forecast
  end
end