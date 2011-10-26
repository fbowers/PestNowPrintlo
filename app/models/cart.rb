class Cart < ActiveRecord::Base
  set_table_name "Carts"
  set_primary_key "CartId"


  has_many :orderchemicals,  :foreign_key => :CartId

  #def initialize(chemical)
  #  @chemical = chemical
   
 # end



  def add_product(chemical)
  #  @item_quan = chemical.Increment
  @item_quan = 25
current_item = orderchemicals.find_by_ChemId(chemical)
if current_item
current_item.Quantity += @item_quan
orderchemicals << current_item
else
current_item = orderchemicals.build(:ChemId => chemical)
current_item.Quantity += 0
orderchemicals << current_item
end
current_item
  end


end
