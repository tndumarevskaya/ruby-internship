class User < ApplicationRecord
    scope :p29, -> {where('length(first_name)>5 and length(last_name)<6')}
    has_many :orders
    has_one :passport_data
end
