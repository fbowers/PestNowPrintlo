class Warrantytype < ActiveRecord::Base
   set_table_name "rwarrantytypes"
  set_primary_key "WarrantyTypeId"


 has_many :Warranties,  :foreign_key => :WarrantyTypeId
 
end