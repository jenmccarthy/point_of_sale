require 'active_record'
require 'rspec'
require 'cashier'
require 'sale'
require 'purchase'
require 'customer'
require 'product'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)


RSpec.configure do |config|
  config.after(:each) do
    Cashier.all.each { |cashier| cashier.destroy }
    Customer.all.each { |customer| customer.destroy }
    Purchase.all.each { |purchase| purchase.destroy }
    Sale.all.each { |sale| sale.destroy }
    Product.all.each { |product| product.destroy}
  end
end
