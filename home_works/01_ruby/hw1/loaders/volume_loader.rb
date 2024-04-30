require "csv"
require_relative "../classes/volume"
require_relative "../loaders/vm_loader"

class VolumeLoader

  def self.load_data(vms, file_name = "./csv/volumes.csv")
    CSV.foreach(file_name, headers: false) do |row|
      vm_id, hdd_type, hdd_capacity = row.map(&:strip)
      vms.add_volume(vm_id.to_i, Volume.new(hdd_type, hdd_capacity))
    end
    vms
  end

end