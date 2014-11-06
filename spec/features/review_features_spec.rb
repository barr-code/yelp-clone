require 'rails_helper'
require_relative './helpers/user_helper.rb'

describe 'reviewing' do

	before do
		visit '/'
		sign_up
		add_restaurant("KFC")
	end

	it 'allows users to leave a review using a form' do
		visit '/restaurants'
		add_review("KFC", "so so", '3')
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content('so so')
		expect(page).to have_content 'Your review was added successfully.'
	end

	it "does not allow users to review same restaurant twice" do
		visit '/restaurants'
		add_review("KFC", "not bad", "3")
		add_review("KFC", "pretty bad", "1")
		expect(page).not_to have_content "pretty bad"
		expect(page).to have_content "You have already reviewed this restaurant, chump!"
	end

	it 'displays an average rating for all reviews' do
		add_review("KFC", "so so", "3")
		click_link 'Sign out'
		sign_up("new@user.com", "password", "password")
		add_review("KFC","pretty good", "5")
		expect(page).to have_content "Average rating: ★★★★☆"
	end
end