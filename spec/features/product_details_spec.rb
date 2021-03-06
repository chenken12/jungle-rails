require 'rails_helper'

RSpec.feature "Visitor navigates to detail page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see produt details page" do
    # ACT
    visit root_path
    page.first(:link, "Details").click

    # puts page.html 
    expect(page).to have_css 'section.products-show'
    expect(page).to have_css 'article.product-detail'
    expect(page).to have_content('Apparel')

    # DEBUG / VERIFY
    # save_screenshot

  end

end
