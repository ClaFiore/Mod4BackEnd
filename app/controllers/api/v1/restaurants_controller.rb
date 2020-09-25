require 'rest-client'

class Api::V1::RestaurantsController < ApplicationController
    def index
        lat = 38.907192
        long = -77.036873
        start = params[:start]
        url = "https://developers.zomato.com/api/v2.1/search?start=#{start}&lat=#{lat}&lon=#{long}&radius=1000"
     
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
        
        data = data["restaurants"].map do |rest|
            { 
                id: rest["restaurant"]["id"],
                name: rest["restaurant"]["name"],
                location: rest["restaurant"]["location"],
                cuisines: rest["restaurant"]["cuisines"],
                timings: rest["restaurant"]["timings"],
                price_range: rest["restaurant"]["price_range"],
                thumb: rest["restaurant"]["thumb"],
                rating: rest["restaurant"]["user_rating"]["aggregate_rating"],
                featured_img: rest["restaurant"]["featured_image"],
                phone_numbers: rest["restaurant"]["phone_numbers"]

            }
        end

        render json: data
    end

    def show
    end
end
