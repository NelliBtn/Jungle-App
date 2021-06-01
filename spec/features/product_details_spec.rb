require 'rails_helper'

RSpec.feature "Visitor navigates from home page to a product details page", type: :feature, js: true do

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

  scenario "click on a product => transfered to product's detail page" do
    # ACT
    visit root_path
    first('.product').click_on('Details')

    # VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
    expect(page).to have_content("10")

    # DEBUG
    # puts page.html
    save_screenshot
  end
end
