class GrapeApi
    module Entities
        class Project < Grape::Entity
            expose :name
            expose :state
            expose :created_at
            expose :vms

            def vms
                vms=[]
                object.vms.each do |obj|
                    vms = []
                    hash = {
                        'id' => obj.id,
                        'name' => obj.name,
                        'configuration' => "#{obj.cpu} CPU/#{obj.ram} Gb",
                        'hdd_count' => obj.hdds.size
                    }
                    if options[:detail] == true
                        hash['cost'] = obj.cost
                    end
                    vms << hash
                    
                end
                vms
            end

        end
    end
end