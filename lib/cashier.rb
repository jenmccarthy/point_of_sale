class Cashier < ActiveRecord::Base
  has_many :sales
  has_many :purchases, through: :sales

  def number_of_sales(search_start, search_end)
    self.sales.where(:date => search_start..search_end).count
  end

end
