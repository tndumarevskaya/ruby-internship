class Volume 

  attr_accessor :hdd_type, :hdd_capacity

  def initialize(hdd_type, hdd_capacity)
    @hdd_type = hdd_type
    @hdd_capacity = hdd_capacity.to_i
  end

end