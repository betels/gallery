class UsersController < ApplicationController
   
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
   before_action :correct_user,   only: [:edit, :update]
   before_action :admin_user,     only: :destroy
   
  def index
     @users = User.paginate(page: params[:page])
  end
  def show
    @user = User.find(params[:id])
    #add_to_history
 @purchasehistories = PurchaseHistory.where(user_id: current_user.id)
 
  end

  def new
    @user = User.new
  end
  
  def create
     
    @user = User.new(user_params)
    if @user.save
       log_in @user
      flash[:success] = "Welcome to the gallery!" 
       
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
     flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  #
   def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
   end
   
   # 
   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
   end
   
   def destroy
     if current_user.admin?
        User.find(params[:id]).destroy
        flash[:success] = "User successfully deleted"
        redirect_to users_url
     end
   end
   
    def admin_user
        redirect_to(root_url) unless current_user.admin?
        
    end
   
   private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
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