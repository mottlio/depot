require 'test_helper'


class UserStoriesTest < ActionDispatch::IntegrationTest

  fixtures :products

  #user guest to the index page, selects a product adds it to cart.
  #User checks out, fills details in the checkout form.
  #When they submit an order, an order record is created containing their
  #information, along with a single line item corresponding to the product they
  #added to their cart


  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
        order: { name: "Michal Mottl",
                address: "35 Rue de La",
                email: "michal@formail.com",
                pay_type: "Check"
                }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Michal Mottl", order.name
    assert_equal "35 Rue de La", order.address
    assert_equal "michal@formail.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]

    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["michal@formail.com"], mail.to
    assert_equal "Tango Lingo order confirmation", mail.subject
  end
  #   assert true
  # end
end
