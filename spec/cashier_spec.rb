require 'spec_helper'

describe Cashier do

  it 'will have many sales' do
    test_customer = Customer.create({name: 'Billy the Kid'})
    test_cashier = Cashier.create({name: 'Henry the Eighth'})
    test_sale = Sale.create({customer_id: test_customer.id, cashier_id: test_cashier.id, date: '20140818'})
    test_sale2 = Sale.create({customer_id: test_customer.id, cashier_id: test_cashier.id, date:Time.now})
    expect(test_cashier.sales).to eq [test_sale, test_sale2]
  end

  it 'will have many purchases through sales' do
    test_customer = Customer.create({name: 'Billy the Kid'})
    test_cashier = Cashier.create({name: 'Henry the Eighth'})
    test_sale = Sale.create({customer_id: test_customer.id, cashier_id: test_cashier.id, date: '20140818'})
    test_product = Product.create({name: 'Water', price: 2.99})
    test_product2 = Product.create({name: 'Dirt', price: 6.99})
    test_purchase = Purchase.create({product_id: test_product.id, quantity: 1, sale_id: test_sale.id})
    test_purchase2 = Purchase.create({product_id: test_product2.id, quantity: 2, sale_id: test_sale.id})
    expect(test_cashier.purchases).to eq [test_purchase, test_purchase2]
  end

end

