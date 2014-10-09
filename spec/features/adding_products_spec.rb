require 'spec_helper'

feature 'User adds a product' do
	scenario "when browsing the homepage" do
		expect(Product.count).to eq 0
		visit '/'
		add_product("Sack of potatoes",
					4,
					4.40,
					"A sack, full of potatoes.")
		expect(Product.count).to eq 1
		product = Product.first
		expect(product.product_title).to eq "Sack of potatoes"
		expect(product.quantity).to eq 4
		expect(product.price).to eq 4.40
		expect(product.description).to eq "A sack, full of potatoes."
		expect(product.total_stock_value).to eq 17.60
	end

	scenario "with a few tags" do
		visit '/'
		add_product("Sack of potatoes",
					4,
					4.40,
					"A sack, full of potatoes.",
					['vegetables', 'carbohydrates'])
		product = Product.first
		expect(product.tags.map(&:text)).to include 'vegetables'
		expect(product.tags.map(&:text)).to include 'carbohydrates'
	end

	def add_product(product_title, quantity, price, description, tags = [])
		within('#new-product') do
			fill_in 'product_title', :with => product_title
			fill_in 'quantity', :with => quantity
			fill_in 'price', :with => price
			fill_in 'description', :with => description
			fill_in 'tags', :with => tags.join(' ')
			click_button 'Add product'
		end
	end
end
