class Orderarea< ActiveRecord::Base
   set_table_name "OrderArea"
  set_primary_key "OrderAreaId"


   belongs_to :Order, :foreign_key => :OrderId
   belongs_to :Areatreated, :foreign_key => :AreaTreatedId


end