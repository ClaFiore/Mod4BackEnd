require 'rest-client'

class Api::V1::TablesController < ApplicationController
    skip_before_action :logged_in?, only: [:show]
    def show
        table = Table.find_by(id: params[:id])
        zomato_rest_id = table.restaurant.zomato_rest_id

        url = "https://developers.zomato.com/api/v2.1/restaurant?res_id=#{zomato_rest_id}"

        response = Excon.get(
            url,
            headers: {
            'X-RapidAPI-Host' => URI.parse(url).host,
            'user-key' => "1b316afe0f10805aa36886e94f4f65fe"#"1f5bbdd1226212f97f0e19baadadc96f"
            }
        )

        data = JSON.parse(response.body)
        render json: data


    end
end
