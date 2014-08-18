class Customer < ActiveRecord::Base
  has_many :purchases, through: :sales
  has_many :sales

end
