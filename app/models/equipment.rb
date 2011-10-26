class Equipment< ActiveRecord::Base
   set_table_name "Equipment"
  set_primary_key "id"


   has_many :Orderequipments, :foreign_key => :EquipmentId
    has_many :Orders, :through => :Orderequipments


end
