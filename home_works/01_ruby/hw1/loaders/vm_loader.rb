require "csv"
require_relative '../classes/vm'

class VMLoader

  attr_reader :vms

  def initialize(file_name = "./csv/vms.csv")
    @vms = []
    load_data(file_name)
  end

  def load_data(file_name)
    CSV.foreach(file_name, headers: false) do |row|
      id, cpu, ram, hdd_type, hdd_capacity = row.map(&:strip)
      @vms << VM.new(id, cpu, ram, hdd_type, hdd_capacity)
    end
  end

  def add_volume(vm_id, volume)
    vm = @vms.find { |vm| vm.id == vm_id }

    return nil unless vm

    vm.add_volume(volume)
  end

  def get_vms_by_hdd_type(type)
    @vms.select { |vm| vm.hdd_type == type}
  end

  def get_vms_by_additional_hdd_type(hdd_type = nil)
    @vms.select { |vm| vm.volumes.any? { |volume| volume.hdd_type == hdd_type } || hdd_type.nil? }
  end

end