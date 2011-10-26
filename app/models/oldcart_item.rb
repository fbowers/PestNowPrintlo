class CartItem
  
  attr_reader :chemical, :quantity

  

   def initialize(chemical)
    @chemical = chemical
    #@quantity = @cart.quantity || 10
    @quantity =  10
    @increment = (chemical.Increment) /100
   # @increment = number_with_precision(chemical.Increment , :precision => 2)
  end

  def dec_quantity
    @quantity -=  @increment
  end

  def increment_quantity
     @quantity += @increment
    
  end
  
  def title
    @chemical.ChemicalName
  end

  def meas
    @chemical.Measurement
  end
  
  def chid
    @chemical.ChemicalId
  end
  
  def price
    #@chemical.price * @quantity
     @quantity
  end
end
