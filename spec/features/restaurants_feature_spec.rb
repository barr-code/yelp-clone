require 'rails_helper'
require_relative './helpers/user_helper'

describe 'restaurants' do

	before do
		visit '/'
		sign_up
	end

	context 'no restaurants have been added' do

		it 'displays a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do

		before do
			add_restaurant("KFC")
		end

		it 'should display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurants yet')
		end
	end

	context 'creating restaurants' do

		it 'prompts users to fill out a form, then displays the new restaurant' do
			visit '/restaurants'
			add_restaurant("KFC")
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		it "does not let you submit a name that is too short" do
			visit '/restaurants'
			add_restaurant("kf")
			expect(page).not_to have_css 'h2', text: 'kf'
			expect(page).to have_content 'error'
		end
	end

	context 'viewing restaurants' do

		before do
			@kfc = Restaurant.create(name: 'KFC')
		end

		it 'lets a user view a restaurant' do
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{@kfc.id}"
		end
	end

	context 'editing restaurants' do

		before do
			visit '/'
			add_restaurant("KFC")
		end

		it 'lets a user edit a restaurant' do
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_on 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'deleting a restaurant' do
		before do
			add_restaurant("KFC")
		end

		it "removes a restaurant when a user clicks a delete link" do
			visit '/restaurants'
			click_link 'Delete KFC'
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content 'Restaurant deleted successfully'
		end

	end

end