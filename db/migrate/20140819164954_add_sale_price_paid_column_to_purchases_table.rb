class AddSalePricePaidColumnToPurchasesTable < ActiveRecord::Migration
  def change
    add_column :purchases, :price_paid, :float
  end
end
