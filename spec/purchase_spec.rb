require 'spec_helper'

describe Purchase do
  it 'belongs to a product' do
    test_product = Product.create({name: 'Gerbil Dentures', price: 456.99})
    test_purchase = Purchase.create({product_id: test_product.id, quantity: 1, sale_id: 37})
    expect(test_purchase.product).to eq test_product
  end

  it 'calculates a purchase row price paid' do
    test_purchase = Purchase.create({product_id: 1, quantity: 2, sale_id: 37, price_paid: 45.00})
    expect(test_purchase.purchase_total).to eq 90.00
  end
end
