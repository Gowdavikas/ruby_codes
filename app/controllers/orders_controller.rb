class OrdersController < ApplicationController

    def index
        @orders = Order.all
        if @orders.empty?
            render json:{
                message: "No order details found"
            }, status: 404
        else
            render json:{
                message: "Fetched all order details",
                order: @orders
            }, status: 200
        end
    end

    def show
        order = set_orders
        if order
            render json:
            {
                message: "Given order id detail found",
                order: order
            }, status: 200
        else
            render json:{
                message: "No details found for given order id"
            }, status: 404
        end
    end

    def create
        order = Order.create(order_params)
        if order.save
            render json:{
                message: "New order details created",
                order: order
            }, status: 201
        else
            render json:{
                message: "order details failed to Create"
            }, status: 400
        end
    end
    
    def update
        order = set_orders
        if order.update(order_params)
            render json:
            {
                message: "Order detail updated successfully",
                order: order
            }, status: 200
        else
            render json:
            {
                message: "Order details failed to update!"
            }, status: 400
        end
    end

    def destroy
        order = set_order
        if order
            render json:{
                message: "Order deleted Successfully",
                order: order
            }, status: 200
        else
            render json:{
                message: "Order failed to delete!"
            }, status: 400
        end
    end

    private
    def set_orders
        order = Order.find_by(id: params[:id])
        if order
            return order
        end
    end

    def order_params
        params.permit(:user_id, :product_id, :quantity, :total_price)
    end
    
end
