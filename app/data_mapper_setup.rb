env = ENV["RACK_ENV"] || "development"

require_relative 'model/product'
require_relative 'model/tag'
require_relative 'model/user'

DataMapper.setup(:default, "postgres://localhost/shop_manager_#{env}")
DataMapper.finalize
DataMapper.auto_migrate!