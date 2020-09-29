class Api::V1::ReservationsController < ApplicationController
    def index
    end

    def create
        zomatoId = params[:restId].to_i
        rest = Restaurant.find_by(zomato_rest_id: zomatoId)
        party = params[:party].to_i
        date = params[:date]
        hour = params[:hour]
        tables = rest.tables.where("seats >= #{party}")
        table = tables.find do |t| 
            t.reservations.where(date: Date.parse(date), hour: hour).count == 0
        end
        
        reservation = Reservation.new(table_id: table.id, user_id: @user.id, party: party, date: date, hour: hour)
        if reservation.valid?
            reservation.save
            render json: {message: 'Reservation was successfully created'}
        else
            render json: {error: 'Failed to create new reservation'}
        end
    end

    def update
    end

    def destroy
        reservation = Reservation.find_by(id: params[:id])

        render json: {message: "Reservation has been deleted"}
    end

end
