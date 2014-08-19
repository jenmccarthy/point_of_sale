class Purchase < ActiveRecord::Base
  belongs_to :product


  def purchase_total
    self.quantity * self.price_paid
  end



end
