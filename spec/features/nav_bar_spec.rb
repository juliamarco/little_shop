require 'rails_helper'

RSpec.describe 'User sees nav bar' do
  context 'as admin' do
    it 'allows admin to see all admin links' do
      admin = User.create(username: "Whatever", password: 'yes', role: 1, email: "whatever@gmail.com", address: "larimer", city: "denver", state: "co", zip_code: 80124, active: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      expect(page).to have_link("All Users")
      expect(page).to have_link("Dashboard")

      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Cart")
    end
  end
end