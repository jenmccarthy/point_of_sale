class Sale < ActiveRecord::Base
  has_many :purchases
  belongs_to :customer
  belongs_to :cashier
end
