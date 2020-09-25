require 'rest-client'

class Api::V1::RestaurantsController < ApplicationController
    def index
        lat = 38.907192
        long = -77.036873
        url = "https://developers.zomato.com/api/v2.1/search?lat=#{lat}&lon=#{long}&radius=1000"
     
        response = Excon.get(
            url,
            headers: {
            'X-RapidAPI-Host' => URI.parse(url).host,
            'user-key' => ENV.fetch("RAPIDAPI_API_KEY")
            }
        )

        data = JSON.parse(response.body)
        data["restaurants"].each do |rest|
            Restaurant.find_or_create_by(zomato_rest_id: rest["restaurant"]["id"])
        end

        render json: data
    end

    def show
    end
end
