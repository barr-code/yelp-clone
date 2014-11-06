class ReviewsController < ApplicationController

	before_action :authenticate_user!

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		review = @restaurant.reviews.new(review_params)
		review.user_id = current_user.id
		if review.save
			redirect_to restaurants_path
			flash[:notice] = "Your review was added successfully."
		else
			redirect_to restaurants_path
			flash[:error] = "You have already reviewed this restaurant, chump!"
		end
	end

	private

	def review_params
		params.require(:review).permit(:thoughts, :rating)
	end
end
