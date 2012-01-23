class Orderchemical < ActiveRecord::Base
   set_table_name "OrderChemicals"
  set_primary_key "OrderChemicalId"

   belongs_to :Order, :foreign_key => :OrderId
  # accepts_nested_attributes_for :Order
   belongs_to :Chemical, :foreign_key => :ChemId
 # accepts_nested_attributes_for :Chemical
  # belongs_to :Cart, :foreign_key => :CartId

end
