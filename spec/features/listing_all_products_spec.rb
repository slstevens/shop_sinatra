require 'spec_helper'

feature "User browses the list of products" do

	before(:each) {
		Product.create(:product_title => "Sack of potatoes",
					   :quantity => 1,
					   :price => 4.40)
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Sack of potatoes")
	end
end