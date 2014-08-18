require 'spec_helper'

describe Product do
  it 'has many purchases' do
    test_product = Product.create({name: 'Gerbil Dentures', price: 456.99})
    test_purchase1 = Purchase.create({product_id: test_product.id, quantity: 1, sale_id: 37})
    test_purchase2 = Purchase.create({product_id: test_product.id, quantity: 15, sale_id: 37})
    test_purchase3 = Purchase.create({product_id: test_product.id, quantity: 16, sale_id: 39})
    expect(test_product.purchases).to eq [test_purchase1, test_purchase2, test_purchase3]
  end

end
