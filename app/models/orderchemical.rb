class Orderchemical < ActiveRecord::Base
   set_table_name "OrderChemicals"
  set_primary_key "OrderChemicalId"

  # belongs_to :Order, :foreign_key => :OrderId
   belongs_to :Chemical, :foreign_key => :ChemId
  # belongs_to :Cart, :foreign_key => :CartId

end
