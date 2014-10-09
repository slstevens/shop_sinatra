require 'spec_helper'

feature "User browses the list of products" do

	before(:each) {
		Product.create(:product_title => "Sack of potatoes",
					   :quantity => 1,
					   :price => 4.40,
					   :description => "A sack full of potatoes",
					   :tags => [Tag.first_or_create(:text => 'boring')])
		Product.create(:product_title => "Apples",
					   :quantity => 1,
					   :price => 4.40,
					   :description => "Tasty fruit",
					   :tags => [Tag.first_or_create(:text => 'fruit')])
		Product.create(:product_title => "Oranges",
					   :quantity => 1,
					   :price => 4.40,
					   :description => "Tasty orange fruit",
					   :tags => [Tag.first_or_create(:text => 'fruit')])
		Product.create(:product_title => "Bacon",
					   :quantity => 1,
					   :price => 4.40,
					   :description => "Tasty breakfast goodness",
					   :tags => [Tag.first_or_create(:text => 'meat')])
		Product.create(:product_title => "Chicken Wings",
					   :quantity => 1,
					   :price => 4.40,
					   :description => "Hmmm meat",
					   :tags => [Tag.first_or_create(:text => 'meat')])
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Sack of potatoes")
	end

	scenario "filtered by a tag" do
		visit '/tags/fruit'
		expect(page).not_to have_content("Bacon")
		expect(page).not_to have_content("Chicken Wings")
		expect(page).to have_content("Apples")
		expect(page).to have_content("Oranges")
	end
end