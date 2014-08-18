require 'active_record'
require './lib/product.rb'
require './lib/cashier.rb'
require './lib/customer.rb'
require './lib/purchase.rb'
require './lib/sale.rb'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)



def menu
  choice = nil
  until choice == 'x'
    system("clear")
    puts "Point of Sale Management"
    puts "-------------"
    puts "[1] Cashier Point of Sale Menu"
    puts "[2] Manager Menu"
    puts "[x] Exit"
    puts "\n\nEnter a choice: "
    choice = gets.chomp
    case choice
    when '1'
      cashier_menu
    when '2'
      manager_menu
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def manager_menu
  choice = nil
  until choice == 'x'
    puts "Manager Menu"
    puts "-------------"
    puts "[1] Add cashier login"
    puts "[2] Add Product"
    puts "[3] Remove cashier login"
    puts "[4] Remove Product"
    puts "[5] View all products"
    puts "[6] View all cashier logins"
    puts "[7] Total Sales by date range"
    puts "[x] Exit"
    puts "\n\nEnter a choice: "
    choice = gets.chomp
    case choice
    when '1'
      manager_add_login
    when '2'
      manager_add_product
    when '3'
      manager_remove_login
    when '4'
      manager_remove_product
    when '5'
      manager_view_products
    when '6'
      manager_view_logins
    when '7'
      manager_total_sales
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def cashier_menu
  choice = nil
  until choice == 'x'
    puts "Cashier Menu"
    puts "-------------"
    puts "[1] Add customer"
    puts "[2] Create a Sale"
    puts "[3] Remove customer"
    puts "[4] View customers"
    puts "[5] View Sales"
    puts "[6] Return Sales"
    puts "[x] Exit"
    puts "\n\nEnter a choice: "
    choice = gets.chomp
    case choice
    when '1'
      cashier_add_customer
    when '2'
      cashier_create_sale
    when '3'
      cashier_remove_customer
    when '4'
      cashier_view_customers
    when '5'
      cashier_view_sales
    when '6'
      cashier_mark_sale_returned
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def manager_add_login
  puts "Enter the cashier name: "
  name_inp = gets.chomp
  new_cashier = Cashier.create({name: name_inp})
  puts "Cashier created: #{new_cashier.name}\n\n"
end

def manager_view_logins
  puts "These are your current cashiers:"
  Cashier.all.each do |cashier|
    puts "[#{cashier.id}]--#{cashier.name}"
  end
  puts "\n\n"
end

def manager_remove_login
  manager_view_login
  puts "\n\nWhich cashier [#] would you like to remove?"
  cashier_input = gets.chomp.to_i
  result = Cashier.find(cashier_input)
  puts "#{result.name} has been deleted"
  Cashier.find(cashier_input).delete
  puts "\n\n"
end

def manager_add_product
print "\n\nEnter product name: "
product_inp = gets.chomp
print "\n\nEnter product price (Number only, decimal ok): $"
price_input = gets.chomp.to_f
result = Product.create({name: product_inp, price: price_input})
puts "Product added => name: #{result.name} price: $#{result.price}\n\n"
end

def manager_view_products
  puts "\n\nCurrent Product List: "
  Product.all.each do |product|
    puts "[#{product.id}]--#{product.name}"
  end
  puts "\n\n"
end

def manager_remove_product
  manager_view_products
  print "\n\nChoose [#] of product to delete: "
  prod_inp = gets.chomp.to_i
  result = Product.find(prod_inp)
  puts "#{result.name} deleted"
  result.delete
  puts "\n\n"
end

def cashier_add_customer
  puts "\n\nPlease enter a customer name:"
  customer_name = gets.chomp
  new_customer = Customer.create({name: customer_name})
  puts "Customer #{new_customer.name} has been added to the system\n\n"
end

def cashier_view_customers
  puts "\n\n Current customer list: "
  Customer.all.each do |customer|
    puts "[#{customer.id}]--#{customer.name}"
  end
  puts "\n\n"
end

def cashier_remove_customer
  cashier_view_customers
  print "\n\nChoose [#] of customer you would like to delete: "
  customer_input = gets.chomp.to_i
  result = Customer.find(customer_input)
  puts "#{result.name} has been deleted"
  result.delete
  puts "\n\n"
end








menu
