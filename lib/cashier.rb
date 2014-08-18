class Cashier < ActiveRecord::Base
  has_many :sales
  has_many :purchases, through: :sales
end
