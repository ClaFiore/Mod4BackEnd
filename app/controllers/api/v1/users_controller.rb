class Api::V1::UsersController < ApplicationController
    skip_before_action :logged_in?, only: [:create]

    def index
        users = User.all 
        render json: users, except: [:updated_at, :created_at], include: [:reservations => {except: [:created_at, :updated_at]}]
    end

    def show
        render json: @user, except: [:updated_at, :created_at], include: [:reservations => {except: [:created_at, :updated_at]}]
    end

    def create
        user = User.new(user_params)
        if user.valid?
            user.save
            render json: {username: user.username, token: encode_token({user_id: user.id})}, status: 200
        else
            render json: {error: user.errors.full_messages}, status: :not_acceptable
        end
    end

    def update
        @user.update(user_params)
        if @user.valid?
            @user.save
            render json: {message: 'Updated Successfully'}, status: 200
        else
            render json: {error: @user.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        @user.destroy
        
    end

    private

    def user_params
        params.permit(:username, :password, :first_name, :last_name, :email, :address)
    end
end
