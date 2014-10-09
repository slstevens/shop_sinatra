class Product

	include DataMapper::Resource

	property :id,				Serial
	property :product_title, 	String
	property :quantity, 		Integer
	property :price, 			Float
	property :description, 		String

	# has n, :tags, :through => Resource
end
