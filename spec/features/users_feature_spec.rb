require 'rails_helper'
require_relative './helpers/user_helper'

context 'user not signed in and on the homepage' do
	it 'should see a "sign in" link and a "sign up" link' do
		visit '/'
		expect(page).to have_link 'Sign in'
		expect(page).to have_link 'Sign up'
	end

	it 'should not see "sign out" link' do
		visit '/'
		expect(page).not_to have_link 'Sign out'
	end
end

context 'user signed in and on the homepage' do

	before do
		visit '/'
		sign_up
	end

	it 'should see "sign out" link' do
		visit '/'
		expect(page).to have_link 'Sign out'
	end

	it 'should not see a "sign in" link and "sign up" link' do
		visit '/'
		expect(page).not_to have_link 'Sign in'
		expect(page).not_to have_link 'Sign up'
	end
end

context 'user not signed in' do

	it 'must be logged in to create restaurants' do
		visit '/'
		click_link 'Add a restaurant'
		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end

	it 'must be logged in to edit restaurants' do
		visit '/'
		expect(page).not_to have_content "Edit Vic's Cafe"
	end

	it 'must be logged in to delete a restaurant' do
		visit '/'
		expect(page).not_to have_content "Delete Vic's Cafe"
	end

end

context 'user lacks authorization' do

	before do
		visit '/'
		sign_up
		add_restaurant
		click_on 'Sign out'
	end

	it 'must be logged in to leave a review' do
		visit '/'
		click_link "Review Vic's Cafe"
		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end

	it 'cannot edit a restaurant that it did not create' do
		sign_up("newuser@test.com", "hercules", "hercules")
		expect(page).not_to have_link "Edit Vic's Cafe"
	end

	it 'cannot delete a restaurant that it did not create' do
		sign_up('newuser@test.com', 'hercules', 'hercules')
		expect(page).not_to have_link "Delete Vic's Cafe"
	end
end

