require_relative '../loaders/vm_loader'
require_relative '../loaders/price_loader'
require_relative '../loaders/volume_loader'

class Report

  def initialize
    @vms = VMLoader.new
    @vms = VolumeLoader.load_data(@vms)
    @prices = PriceLoader.new
  end

  def calculate_price
    result = []

    @vms.vms.each do |vm|
      price = vm.cpu * @prices.get_price("cpu") + vm.ram * @prices.get_price("ram") +
                    vm.hdd_capacity * @prices.get_price(vm.hdd_type)
      vm.volumes.each {|volume| price += volume.hdd_capacity * @prices.get_price(volume.hdd_type)}
       
      result << {id: vm.id, arg: price}
    end

    result
  end


  def calculate_additional_volume(hdd_type = nil)
    result = []
  
    @vms.vms.each do |vm|
      volume_capacity = 0
      vm.volumes.each do |volume|
        volume_capacity += volume.hdd_capacity if hdd_type.nil? || volume.hdd_type == hdd_type
      end
  
      result << {id: vm.id, arg: volume_capacity, hdd_type: hdd_type}
    end
  
    result
  end


  def sorted_vms(result, n, sort_order)
    result.sort_by{ |vm| sort_order * vm[:arg] }
          .last(n)
          .reverse
  end
  
  def expensive_vm(n)
    result = calculate_price
    sorted_vms(result, n, 1)
  end
  
  def cheap_vm(n)
    result = calculate_price
    sorted_vms(result, n, -1)
  end
  
  def big_volume(n, type)
    result = @vms.get_vms_by_hdd_type(type).map do |vm|
                { id: vm.id, arg: vm.hdd_capacity, hdd_type: vm.hdd_type }
              end
    sorted_vms(result, n, 1)
  end

  def additional_volume_number(n, hdd_type = nil)
    vms = @vms.get_vms_by_additional_hdd_type(hdd_type)

    result = vms.map do |vm|
      arg = if hdd_type
              vm.volumes.count { |volume| volume.hdd_type == hdd_type }
            else
              vm.volumes.size
            end
  
      { id: vm.id, arg: arg, hdd_type: hdd_type }
    end

    sorted_vms(result, n, 1)
  end

  def additional_volume_capacity(n, hdd_type = nil)
    result = calculate_additional_volume(hdd_type)

    sorted_vms(result, n, 1)
  end
  
end