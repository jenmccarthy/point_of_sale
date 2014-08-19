class Product < ActiveRecord::Base
  has_many :purchases

  def number_of_purchases
    sum = 0
    results = self.purchases.where(product_id: self.id)
    results.each do |result|
      sum += result.quantity
    end
    sum
  end

end
