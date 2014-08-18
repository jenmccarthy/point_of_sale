require 'spec_helper'

describe Sale do
  it 'adds new sale objects' do
    test_customer = Customer.create({name: 'Billy the Kid'})
    test_cashier = Cashier.create({name: 'Henry the Eighth'})
    test_sale = Sale.create({customer_id: test_customer.id, cashier_id: test_cashier.id, date: '20140818'})
    expect(Sale.all).to eq [test_sale]
  end
end
