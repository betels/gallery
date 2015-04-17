class CartController < ApplicationController
 
  ##############--------------##############
  def index
    @cart = session[:cart] || {}
  end
  
  ##############--------------##############
  def add
    id = params[:id]
    cart = session[:cart] ||= {}
    cart[id] = (cart[id] || 0) + 1
    redirect_to :action => :index
  end
  
  ##############--------------##############
  def change
    cart = session[:cart]
    id = params[:id];
    quantity = params[:quantity].to_i
    if cart and cart[id] 
      unless quantity <= 0
        cart[id] = quantity
      else
       cart.delete id
      end
    end
    redirect_to :action => :index
  end
  
  ###---------####
  def checkout
    add_to_history
    @purchasehistories = PurchaseHistory.where(user_id: current_user.id)
  end
######....#####
 def thankyou 
  
 end
  

 
  ### -- ---###
  def add_to_history
    cart = session[:cart]                                                                                
    cart.each do | id, quantity |
      art = Art.find_by_id(id)
     
        @purchaseHistory = PurchaseHistory.new(
                                                  art_id: art.art_id, 
                                                  title: art.name, 
                                                  price: art.price, 
                                                  quantity: quantity, 
                                                  total: (quantity * art.price), 
                                                  user_id: current_user.id
                                                  )
        @purchaseHistory.save
   
   end
  end
end
