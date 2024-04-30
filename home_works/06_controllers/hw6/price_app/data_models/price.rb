class Price

  attr_accessor :type, :price

  def initialize (type, price)
    @type = type
    @price = price.to_i
  end
  
end