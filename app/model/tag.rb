class Tag

  include DataMapper::Resource

  has n, :products, :through => Resource

  property :id, Serial
  property :text, String

end