require 'rest-client'

class Api::V1::RestaurantsController < ApplicationController
    skip_before_action :logged_in?, only: [:index, :show]
    
    def index
        
        lat = 38.907192
        long = -77.036873
        start = params[:start]
        if !params[:cuisines]
            url = "https://developers.zomato.com/api/v2.1/search?start=#{start}&lat=#{lat}&lon=#{long}&radius=1000"
        else
            cuisines = params[:cuisines]
            url = "https://developers.zomato.com/api/v2.1/search?start=#{start}&lat=#{lat}&lon=#{long}&radius=20000&cuisines=#{cuisines}"
        end
        response = Excon.get(
            url,
            headers: {
            'X-RapidAPI-Host' => URI.parse(url).host,
            'user-key' => "1b316afe0f10805aa36886e94f4f65fe"#"1f5bbdd1226212f97f0e19baadadc96f"
            }
        )

        data = JSON.parse(response.body)
     
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

        data.each do |rest|
            r = Restaurant.find_or_create_by(zomato_rest_id: rest[:id])
                if r.tables.length == 0 
                    rand(10..20).times do
                        Table.create(restaurant_id: r.id, seats: rand(2..8))
                    end
                end
        end
    end

    def show
        
        rest = Restaurant.find_by(zomato_rest_id: params[:id])
        availableHours = rest.availableHours(params[:date], params[:party_size])
        render json: availableHours
    end
end
