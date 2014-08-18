require 'spec_helper'

describe Purchase do
  it 'belongs to a product' do
    test_product = Product.create({name: 'Gerbil Dentures', price: 456.99})
    test_purchase = Purchase.create({product_id: test_product.id, quantity: 1, sale_id: 37})
    expect(test_purchase.product).to eq test_product
  end
end
