require 'spec_helper'

describe Product do

	context 'testing that datamapper works' do

		it 'should be created and then retrieved from the db' do
			expect(Product.count).to eq 0
			Product.create!(:product_title => "Sack of potatoes",
						   :quantity => 1,
						   :price => 4.40)
			expect(Product.count).to eq 1
			product = Product.first
			expect(product.product_title).to eq "Sack of potatoes"
			expect(product.quantity).to eq 1
			expect(product.price).to eq 4.40
			product.destroy
			expect(Product.count).to eq 0
		end
	end
end
