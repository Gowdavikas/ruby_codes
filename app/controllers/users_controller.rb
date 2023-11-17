class UsersController < ApplicationController

    def index
        @users = User.all
        if @users.empty?
            render json:{
                message: "No user details found"
            }, status: 404
        else
            render json:{
                message: "User details found",
                user: @users
            }, status: 200
        end
    end

    def show
        user = set_user
        if user
            render json:
            {
                message: "Given user details found",
                user: user
            }, status: 200
        else
            render json:{
                message: "No details found for given user id"
            }, status: 404
        end
    end


    def create
        user = User.create(user_params)
        if user.save
            render json:{
                message: "New User details created",
                user: user
            }, status: 201
        else
            render json:{
                message: "Details failed to Create"
            }, status: 400
        end
    end
    
    def update
        user = set_user
        if user.update(user_params)
            render json:
            {
                message: "User detail updated successfully",
                user: user
            }, status: 200
        else
            render json:
            {
                message: "User details failed to update!"
            }, status: 400
        end
    end

    def destroy
        user = set_user

        if user
            render json:{
                message: "User deleted Successfully",
                user: user
            }, status: 200
        else
            render json:{
                message: "User failed to delete!"
            }, status: 400
        end
    end



    private
    def set_user
        user = User.find_by(id: params[:id])
        if user
            return user
        end
    end

    def user_params
        params.permit(:username, :email, :password)
    end
end
