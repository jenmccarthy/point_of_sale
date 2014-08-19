require 'spec_helper'

describe Sale do
  it 'adds new sale objects' do
    test_customer = Customer.create({name: 'Billy the Kid'})
    test_cashier = Cashier.create({name: 'Henry the Eighth'})
    test_sale = Sale.create({customer_id: test_customer.id, cashier_id: test_cashier.id, date: '20140818'})
    expect(Sale.all).to eq [test_sale]
  end

  it 'has many purchases' do
    test_sale = Sale.create({customer_id: 1, cashier_id: 1, date: Time.now})
    test_purchase1 = Purchase.create({product_id: 123, quantity: 1, sale_id: test_sale.id})
    test_purchase2 = Purchase.create({product_id: 456, quantity: 1, sale_id: test_sale.id})
    expect(test_sale.purchases).to eq [test_purchase1, test_purchase2]
  end

  it 'has many products through purchases' do
    test_product = Product.create({name: 'Pizza', price: 5.99})
    test_sale = Sale.create({date: Time.now, customer_id: 1, cashier_id: 1})
    test_purchase = Purchase.create({product_id: test_product.id, quantity: 2, sale_id: test_sale.id})
    expect(test_sale.products).to eq [test_product]
  end

  it 'belongs to a customer, belongs to a cashier' do
    test_customer = Customer.create({name: 'Joseph'})
    test_cashier = Cashier.create({name: 'Chachi'})
    test_sale = Sale.create({customer_id: test_customer.id, cashier_id: test_cashier.id, date: Time.now})
    expect(test_sale.customer).to eq test_customer
    expect(test_sale.cashier).to eq test_cashier
  end

  it 'will return sales in a date range' do
    test_sale1 = Sale.create({customer_id: 1, cashier_id: 1, date: "2014-03-16"})
    test_sale2 = Sale.create({customer_id: 1, cashier_id: 1, date: "2014-08-19"})
    expect(Sale.date_search("2014-08-19", "2014-08-20")).to eq [test_sale2]
  end

  it 'will return the total from a sale' do
    test_sale1 = Sale.create({customer_id: 1, cashier_id: 1, date: "2014-03-16"})
    test_product = Product.create({name: 'Pizza', price: 3.50})
    test_purchase = Purchase.create({product_id: test_product.id, quantity: 2, sale_id: test_sale1.id, price_paid: test_product.price})
    expect(test_sale1.total_paid).to eq 7.00
  end
end
