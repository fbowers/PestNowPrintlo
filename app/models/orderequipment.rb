class Orderequipment< ActiveRecord::Base
   set_table_name "OrderEquipment"
  set_primary_key "OrderEquipmentId"


   belongs_to :Order, :foreign_key => :OrderId
   belongs_to :Equipment, :foreign_key => :EquipmentId


end