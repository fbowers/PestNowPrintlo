
class Cart
  
  attr_reader :items, :quantity
  
  def initialize
    @items = []
  end
  


  def add_product2(chemical)
    current_item = @items.find {|item| item.chemical == chemical}
    if current_item
      #  params[:quanza].blank? ? current_item.increment_quantity:
        #  current_item.quantity = params[quanza]
           current_item.quantity = 16
    else
      current_item = CartItem.new(chemical)
    #   unless params[:quanza].blank? current_item.quantity = params[quanza]
      @items << current_item
    end
    current_item
  end
 # end

def add_to_c(chemcial)
 current_item = @items.find {|item| item.chemical == chemical}
   if current_item
    params[:quantity].blank? ? current_item.increment_quantity :
current_item.quantity = params[:quantity]
   else
     current_item = CartItem.new(chemical)
     unless  params[:quantity].blank? current_item.quantity =
params[:quantity]
     @items << current_item
   end
   current_item
 end
end


  def add_product(chemical)
    current_item = @items.find {|item| item.chemical == chemical}
    if current_item
      current_item.increment_quantity
     # current_item.quantity = 25
    else
      current_item = CartItem.new(chemical)
      @items << current_item
    end
    current_item
  end

  def sub_product(chemical)
    current_item = @items.find {|item| item.chemical == chemical}
    if current_item

      current_item.dec_quantity
    else
      current_item = CartItem.new(chemical)
      @items << current_item
    end
    current_item
  end

  #START:total_items
  def total_items
    @items.sum { |item| item.quantity }
  end
  #END:total_items
  
  #def total_price
   # @items.sum { |item| item.price }
   # @items.sum { |item| item.quantity }
  #end
end
