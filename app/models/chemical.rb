class Chemical< ActiveRecord::Base
   set_table_name "Chemicals"
  set_primary_key "ChemId"


 
  has_many :Orders, :foreign_key => :ChemicalId
   has_many :Orderchemicals, :foreign_key => :ChemId
#   accepts_nested_attributes_for :Orderchemicals


  
    
end
