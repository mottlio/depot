require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add duplicate products to the cart" do
    cart = carts(:cart2)
    multiple = 2
    multiple.times { cart.add_product(products(:ruby).id).save! }

    assert_equal 2, cart.line_items(true).size
    assert_equal 2, cart.line_items[1].quantity



  end
end
