require 'sinatra'
require 'data_mapper'

require_relative 'model/product'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/shop_manager_#{env}")

require './app/model/product'
require './app/model/tag'
DataMapper.finalize
DataMapper.auto_upgrade!

	get '/' do
		@products = Product.all
		erb :index
	end

	post '/products' do
		product_title = params["product_title"]
		quantity = params["quantity"]
		price = params["price"]
		description = params["description"]
		tags = params["tags"].split(" ").map do |tag|
			Tag.first_or_create(:text => tag)
		end
		Product.create(:product_title => product_title,
					   :quantity => quantity,
					   :price => price,
					   :description => description,
					   :tags => tags,
					   :total_stock_value => (quantity.to_i * price.to_f))
		redirect to('/')
	end