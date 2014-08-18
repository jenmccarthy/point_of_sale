class CreateSalesReturnedColumn < ActiveRecord::Migration
  def change
      add_column :sales, :returned, :boolean
  end
end
