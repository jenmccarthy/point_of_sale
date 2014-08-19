class Sale < ActiveRecord::Base
  has_many :purchases
  has_many :products, through: :purchases
  belongs_to :customer
  belongs_to :cashier

  def self.date_search(search_start, search_end)
    all_sales = self.where(:date => search_start..search_end)
  end


end
