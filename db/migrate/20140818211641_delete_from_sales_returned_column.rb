class DeleteFromSalesReturnedColumn < ActiveRecord::Migration
  def change
    remove_column :sales, :returned, :boolean
  end
end
