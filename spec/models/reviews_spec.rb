require 'rails_helper'

RSpec.describe Review do

	it "is invalid if the rating is more than 5" do
		review = Review.new(rating: 10)
		expect(review).to have(1).error_on(:rating)
	end

end