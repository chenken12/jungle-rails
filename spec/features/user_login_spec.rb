require 'rails_helper'

RSpec.feature "User Logins", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(first_name: "Ken", last_name: "Chen", email:"ken@g.com", password: '123456', password_confirmation: '123456')
  end

  scenario "They see all products" do
    # ACT
    visit root_path
    click_on("Login")

    fill_in 'email', with: 'ken@g.com'
    fill_in 'password', with: '123456'

    # DEBUG / VERIFY
    # save_screenshot

    click_on("Submit")
    expect(page).to have_text 'Signed in as '

    # DEBUG / VERIFY
    # save_screenshot
 
  end

end
