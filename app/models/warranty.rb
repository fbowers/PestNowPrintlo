class Warranty < ActiveRecord::Base
   set_table_name "Warranties"
  set_primary_key "WarrantyId"

 belongs_to :Property, :foreign_key => :PropertyId
 belongs_to :Warrantytype, :foreign_key => :WarrantyTypeId
 has_one :Order, :foreign_key => :WarrantyId
end