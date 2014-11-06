def sign_up(email = "test@test.com", password = "password", password_confirmation = "password")
	click_link 'Sign up'
	fill_in 'Email', with: email
	fill_in 'Password', with: password
	fill_in 'Password confirmation', with: password_confirmation
	click_button 'Sign up'
end

def add_restaurant(name = "Vic's Cafe")
	click_link 'Add a restaurant'
	fill_in 'Name', with: name
	click_button 'Create Restaurant'
end