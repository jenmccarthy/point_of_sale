require 'active_record'
require './lib/product.rb'
require './lib/cashier.rb'
require './lib/customer.rb'
require './lib/purchase.rb'
require './lib/sale.rb'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

@current_cashier = nil
@current_sale = nil

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
    puts "[8] View Cashier Productivity"
    puts "[9] View Product Sales"
    puts "[10] Delete all information from the database"
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
    when '8'
      manager_view_cashier_sales
    when '9'
      manager_view_product_sales
    when '10'
      delete_all
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def cashier_menu
  puts "\n\n"
  manager_view_logins
  puts "Choose your [#] employee number: "
  input_choice = gets.chomp
  @current_cashier = Cashier.find(input_choice)
  puts "\n\n#{@current_cashier.name} is currently logged in.\n\n"
  puts "@current_sale.id"
  choice = nil
  until choice == 'x'
    puts "Cashier Menu"
    puts "-------------"
    puts "[1] Add customer"
    puts "[2] Create a Sale"
    puts "[3] Remove customer"
    puts "[4] View customers"
    puts "[5] View Sales"
    puts "[6] View Purchases by Sale id"
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
      cashier_view_purchases_by_sale
    when 'x'
      puts "Logging out #{@current_cashier}."
      @current_cashier = nil
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def delete_all
  puts "You are going to wipe the entire database. Are you sure y/n"
  doomsday_choice = gets.chomp
  if doomsday_choice == 'y'
    Cashier.all.each { |cashier| cashier.destroy }
    Customer.all.each { |customer| customer.destroy }
    Purchase.all.each { |purchase| purchase.destroy }
    Sale.all.each { |sale| sale.destroy }
    Product.all.each { |product| product.destroy}
  else
    puts "Disaster averted."
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
    puts "[#{product.id}] -- #{product.name} -- $#{product.price}"
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

def manager_total_sales
  puts "\n\nenter start date to search from yyyy/mm/dd :"
  start_inp = gets.chomp
  puts  "enter stop date for search yyyy/mm/dd :"
  stop_inp = gets.chomp
  sale_arr = Sale.date_search(start_inp, stop_inp)
  sum = 0
  sale_arr.each do |each_sale|
    sum += each_sale.total_paid
  end
  print "The total gross sales revenue: $#{sum}\n\n"
end

def manager_view_cashier_sales
  puts "\n\nenter start date to search from yyyy/mm/dd :"
  start_inp = gets.chomp
  puts  "enter stop date for search yyyy/mm/dd :"
  stop_inp = gets.chomp
  Cashier.all.each do |cashier|
    puts "#{cashier.name} has rung up #{cashier.number_of_sales(start_inp, stop_inp)}"
  end
  puts"\n\n"
end

def manager_view_product_sales
  Product.all.each do |product|
    puts "#{product.name} has been sold #{product.number_of_purchases} times."
  end
  puts"\n\n"
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
    puts "[#{customer.id}] -- #{customer.name}"
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

def cashier_create_sale
  puts "\n\n#{@current_cashier.name} [Create Sale]"
  print "Select Customer [#] Id: "
  cashier_view_customers
  customer_inp = gets.chomp.to_i
  current_customer = Customer.find(customer_inp)
  @current_sale = Sale.create({date: Time.now, customer_id: current_customer.id, cashier_id: @current_cashier.id})
  add_choice = nil
  until add_choice == 'n'
    puts "Enter a product y/n"
    add_choice = gets.chomp
    case add_choice
    when 'y'
      add_product_to_purchases
    when 'n'
      puts "done entering."
    else
      puts "y or n"
    end
  end
end

def add_product_to_purchases
  manager_view_products
  puts "choose product [#] to add"
  product = gets.chomp.to_i
  @current_product = Product.find(product)
  puts "enter quantity"
  qty = gets.chomp.to_i
  puts "do you want to add a discount to this item y/n"
  choice = gets.chomp.downcase
  final_total = nil
  if choice == 'y'
    print "Please give a percentage % "
    percent_input = gets.chomp.to_f
    final_total = @current_product.price - (@current_product.price * (percent_input/100))
  else choice == 'n'
    final_total = @current_product.price
  end
  Purchase.create({product_id: product, quantity: qty, sale_id: @current_sale.id, price_paid: final_total})
end

def cashier_view_sales
  puts "\n\nCurrent Sales: "
  puts "[Id] -- Sale date -- Customer Id - Cashier Id"
  puts "---------------------------------------------"
  Sale.all.each do |sale|
    puts "[#{sale.id}] -- #{sale.date} -- #{sale.customer_id} -- #{sale.cashier_id}"
  end
  puts "\n\n"
end

def cashier_view_purchases_by_sale
  cashier_view_sales
  puts "\n\nChoose Sale [#] to view its purchase details"
  sale_choice = gets.chomp.to_i
  current_sale = Sale.find(sale_choice)
  current_sale.purchases.each do |purchase|
    puts "Qty: #{purchase.quantity} -- Prod Id: #{purchase.product_id}"
    current_product = Product.find(purchase.product_id)
    puts "== Item: #{current_product.name}"
    puts "Total Paid: $#{purchase.purchase_total}\n\n"
  end

end




menu
