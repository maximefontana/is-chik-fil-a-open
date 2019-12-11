class PagesController < ApplicationController
  def index
    @location = request.location

    if @location.latitude
      lat = @location.latitude
      lat = 47 if lat == nil
      lon = @location.longitude
      lon = -121 if lon == nil

      url = "https://dev.virtualearth.net/REST/v1/LocalSearch/?query=chik-fil-a&userLocation=#{lat}, #{lon}&key=Ar-ZG4zcP2T6IUb46ga7AIe-pdI5nM1byORM-J9nKnw771uv-MxRFD7gslcsi0gT"
      body = RestClient.get(url)
      @json = JSON.parse(body)
      address = @json["resourceSets"][0]["resources"][0]["Address"]["formattedAddress"]

      chik = Geocoder.search(address)
      chiklat = chik[0].latitude
      chiklon = chik[0].longitude

      @distance = Geocoder::Calculations.distance_between([lat,lon],
        [chiklat, chiklon]).round(1)

    end
  end
end

