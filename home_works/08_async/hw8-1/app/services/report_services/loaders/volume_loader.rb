require "csv"
require_relative "../data_models/volume"
require_relative "../loaders/vm_loader"

class VolumeLoader
  # Метод для загрузки данных о томах и добавления их к соответствующим виртуальным машинам
  def self.load_data(vms, file_name = "app/services/report_services/csv/volumes.csv")
    # Итерация по каждой строке CSV файла
    CSV.foreach(file_name, headers: false) do |row|
      # Разбор данных строки: vm_id, hdd_type, hdd_capacity
      vm_id, hdd_type, hdd_capacity = row.map(&:strip)
      # Добавление тома к виртуальной машине по её идентификатору
      vms.add_volume(vm_id.to_i, Volume.new(hdd_type, hdd_capacity))
    end
    # Возврат объекта vms, содержащего обновленные данные о виртуальных машинах с томами
    vms
  end
end
