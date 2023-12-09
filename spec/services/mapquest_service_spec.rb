require "rails_helper"

RSpec.describe MapquestService do 
  describe "instance methods" do 
    describe "#get_directions" do 
      it "returns a json response with directions" do 
        VCR.use_cassette("mapquest_directions") do 
          start = "Denver,CO"
          destination = "Dillon,CO"
          response = MapquestService.new.get_directions(start, destination)
          expect(response).to be_a(Hash)
          expect(response).to have_key(:route)
          expect(response[:route]).to have_key(:formattedTime)
          expect(response[:route]).to have_key(:legs)
          expect(response[:route][:legs][0]).to have_key(:maneuvers)
          expect(response[:route][:legs][0][:maneuvers][0]).to have_key(:narrative)
          expect(response[:route][:legs][0][:maneuvers][0]).to have_key(:distance)
        end
      end

      it "can return directions using latitude and longitude" do 
        VCR.use_cassette("mapquest_directions_lat_long") do 
          start = "1335 N Sable Blvd, Aurora, CO 80011"
          destination = "39.609475,-106.059580"
          response = MapquestService.new.get_directions(start, destination)
          expect(response).to be_a(Hash)
          expect(response).to have_key(:route)

          response[:route].each do |key, value| 
            expect(response[:route]).to have_key(:sessionId)
            expect(response[:route]).to have_key(:locations)
            expect(response[:route]).to have_key(:legs)
            expect(response[:route]).to have_key(:hasTollRoad)
            expect(response[:route]).to have_key(:hasHighway)
            expect(response[:route]).to have_key(:hasBridge)
            expect(response[:route]).to have_key(:hasUnpaved)
            expect(response[:route]).to have_key(:hasTunnel)
            expect(response[:route]).to have_key(:hasSeasonalClosure)
            expect(response[:route]).to have_key(:hasFerry)
            expect(response[:route]).to have_key(:hasCountryCross)
            expect(response[:route]).to have_key(:hasTimedRestriction)
          end

          response[:route][:legs].each do |leg| 
            expect(leg).to have_key(:maneuvers)
            expect(leg).to have_key(:hasTollRoad)
            expect(leg).to have_key(:hasHighway)
            expect(leg).to have_key(:hasBridge)
            expect(leg).to have_key(:hasFerry)
            expect(leg).to have_key(:hasCountryCross)
            expect(leg).to have_key(:hasTimedRestriction)
            expect(leg).to have_key(:hasTunnel)
            expect(leg).to have_key(:hasUnpaved)
            expect(leg).to have_key(:hasSeasonalClosure)
            expect(leg).to have_key(:distance)
            expect(leg).to have_key(:time)
            expect(leg).to have_key(:formattedTime)
          end

          response[:route][:legs][0][:maneuvers].each do |maneuver|
            expect(maneuver).to have_key(:distance)
            expect(maneuver).to have_key(:narrative)
            expect(maneuver).to have_key(:direction)
            expect(maneuver).to have_key(:directionName)
            expect(maneuver).to have_key(:startPoint)
            expect(maneuver[:startPoint]).to have_key(:lat)
            expect(maneuver[:startPoint]).to have_key(:lng)
            expect(maneuver).to have_key(:index)
            expect(maneuver).to have_key(:formattedTime)
            expect(maneuver).to have_key(:turnType)
            expect(maneuver).to have_key(:transportMode)
            expect(maneuver).to have_key(:streets)
            expect(maneuver).to have_key(:mapUrl) if maneuver[:mapUrl].present?
          end
          
        end
      end
    end
  end
end