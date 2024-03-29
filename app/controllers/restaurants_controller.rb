class RestaurantsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]

	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		if current_user
			@restaurant = Restaurant.new(restaurant_params)
			@restaurant.user_id = current_user.id
		end

		if @restaurant.save
			redirect_to '/restaurants'
		else
			render 'new'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(params[:restaurant].permit(:name))
		redirect_to '/restaurants'
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy
		flash[:notice] = 'Restaurant deleted successfully'
		redirect_to '/restaurants'
	end

	private

	def restaurant_params
		params.require(:restaurant).permit(:name)
	end
end
