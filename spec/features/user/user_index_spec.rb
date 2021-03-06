require 'rails_helper'

RSpec.describe 'user index page' do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    @merchant = create(:user, role: 1)
    @admin = create(:user, role: 2)
  end

  context 'as an admin user' do
    it 'allows an admin to see the user index page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_users_path

      expect(page).to have_content("#{@user.username}")
      expect(page).to have_content("#{@user2.username}")
    end
  end

  context 'a regular user' do
    it "should see a 404" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")
    end
  end

  context 'as a merchant' do
    it "should see a 404" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit admin_users_path

      expect(page).to have_content("That page was too spicy")
    end
  end
end
