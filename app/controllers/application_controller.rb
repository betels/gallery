class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action:set_cart_details
  
 
  def set_cart_details
    cart = session[:cart]
    @total_price = 0
    if(cart)
      @total_arts = session[:cart].size
      cart.each do | id, quantity |
        art = Art.find_by_id(id)
        @total_price += quantity * art.price
      end
    else
      @total_arts = 0
    end
  end
  
end