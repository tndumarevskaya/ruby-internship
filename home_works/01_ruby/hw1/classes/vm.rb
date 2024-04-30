class VM

  attr_accessor :id, :cpu, :ram, :hdd_type, :hdd_capacity, :volumes

  def initialize (id, cpu, ram, hdd_type, hdd_capacity)
    @id = id.to_i
    @cpu = cpu.to_i
    @ram = ram.to_i
    @hdd_type = hdd_type
    @hdd_capacity = hdd_capacity.to_i
    @volumes = []
  end

  def add_volume (volume)
    @volumes << volume
  end

end
