require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/shop_manager_#{env}")

require './app/model/product'
DataMapper.finalize
DataMapper.auto_upgrade!

	get '/' do
		@products = Product.all
		erb :index
	end

	post 'products' do
		product_title = params["product_title"]
		quantity = params["quantity"]
		price = params["price"]
		description = params["description"]
		Product.create(:product_title => product_title,
					   :quantity => quantity,
					   :price => price,
					   :description => description)
		redirect to('/')
	end