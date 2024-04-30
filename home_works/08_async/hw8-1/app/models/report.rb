class Report < ApplicationRecord
  enum report_type: %w[expensive_vm cheap_vm big_volume additional_volume_number additional_volume_capacity]
end