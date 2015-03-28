class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:price)
      @count = increment_count
      @shown_message = "You've been here #{@count} times" if @count >= 5
    end
  end


  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end

end
