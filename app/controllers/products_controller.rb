class ProductsController < ApplicationController

    def index
        @products = Product.all
        if @products.empty?
            render json:{
                message: "No product details found"
            }, status: 404
        else
            render json:{
                message: "Fetched all product details",
                product: @products
            }, status: 200
        end
    end

    def show
        product = set_product
        if product
            render json:
            {
                message: "Given product id detail found",
                product: product
            }, status: 200
        else
            render json:{
                message: "No details found for given product id"
            }, status: 404
        end
    end

    def create
        product = Product.create(product_params)
        if product.save
            render json:{
                message: "New product details created",
                product: product
            }, status: 201
        else
            render json:{
                message: "Details failed to Create"
            }, status: 400
        end
    end
    
    def update
        product = set_product
        if product.update(product_params)
            render json:
            {
                message: "Product detail updated successfully",
                product: product
            }, status: 200
        else
            render json:
            {
                message: "Product details failed to update!"
            }, status: 400
        end
    end

    def destroy
        product = set_product

        if product
            render json:{
                message: "Product deleted Successfully",
                product: product
            }, status: 200
        else
            render json:{
                message: "Product failed to delete!"
            }, status: 400
        end
    end



    private
    def set_product
        product = Product.find_by(id: params[:id])
        if product
            return product
        end
    end

    def product_params
        params.permit(:name, :description, :price, :stock_quantity)
    end
end
