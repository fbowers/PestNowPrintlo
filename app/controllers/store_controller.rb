class StoreController < ApplicationController
  
  #START:before_filter
 # before_filter :find_cart, :except => :empty_cart
  #END:before_filter
  layout 'orderpads'
  def index
    #@chemicals = Chemical.find_chemicals
    @chemicals = Chemical.all
    @cart = current_cart
  end


  def add_to_cart
    begin                     
      chemical = Chemical.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product")
    else
      @current_item = @cart.add_product(chemical)
      redirect_to_index unless request.xhr?
    end
  end


  def sub_to_cart
    begin                 
      chemical = Chemical.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product")
    else
      @current_item = @cart.sub_product(chemical)
      redirect_to_index unless request.xhr?
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end

  #START:checkout
  def checkout
    if @cart.items.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end
  #END:checkout
  
  #START:save_order
  def save_order
    @order = Order.new(params[:order])  
    @order.add_line_items_from_cart(@cart)
    if @order.save        
      session[:cart] = nil
      redirect_to_index("Thank you for your order")
    else
      render :action => :checkout
    end
  end
  #END:save_order
  private
  
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => :index
  end
    
  #START:find_cart
  
  #END:find_cart<
end
