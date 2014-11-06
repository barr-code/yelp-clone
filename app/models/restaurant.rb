class Restaurant < ActiveRecord::Base

	has_many :reviews, dependent: :destroy

	validates :name, length: {minimum: 3}, uniqueness: true

	def average_rating
		return 'No reviews yet' if reviews.none?
		reviews.inject(0) {|memo, review| memo + review.rating} / reviews.size
	end

end