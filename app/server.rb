require 'sinatra'
require 'data_mapper'

require_relative 'model/product'
require_relative 'model/tag'
require_relative 'model/user'
require_relative 'helpers/sessions_helper'
require_relative 'data_mapper_setup'

include SessionsHelper

	enable :sessions
	set :session_secret, 'super secret'

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

	get '/tags/:text' do
		tag = Tag.first(:text => params[:text])
		@products = tag ? tag.products : []
		erb :index
	end


	get '/users/new' do
		@user = User.new
		erb :"users/new"
	end

	post '/users' do
		@user = User.create(:email => params[:email],
              				:password => params[:password],
              				:password_confirmation => params[:password_confirmation])
		session[:user_id] = @user.id
  		redirect to('/')
	end