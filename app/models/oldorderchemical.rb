class Orderchemical< ActiveRecord::Base
   set_table_name "OrderChemicals"
  set_primary_key "OrderChemicalId"

   belongs_to :Order, :foreign_key => :OrderId
   belongs_to :Chemical, :foreign_key => :ChemicalId
   belongs_to :Cart, :foreign_key => :CartId


def add_cart(cart)
    cart.items.each do |item|
    # Orderchemical.Qty = cart.Qty
    #Orderchemical.Qty = item.quantity

    
     li = Orderchemical.from_cart_item(item)
    #  Orderchemicals << li
    end
  end

 def self.from_cart_item(cart_item)
    li = self.new
   # li.Qty     = cart_item.quantity
    li.Qty     = 5
  # li.quantity    = cart_item.quantity
  #  li.total_price = cart_item.price
    li
  end


end
