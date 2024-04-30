class Order < ApplicationRecord
    #before_create :get_price
    enum status: %w[unavailable created started failed removed]
    belongs_to :user
    has_and_belongs_to_many :tags
    has_and_belongs_to_many :networks

    def get_price()
        prices = {
            "sas" => 100,
            "sata" => 200,
            "ssd" => 300
        }
        option = self.options
        price = option["cpu"] * 1000 + option["ram"] * 150 + prices[option["hdd_type"]] * option["hdd_capacity"]
        self.cost = price
    end
end
