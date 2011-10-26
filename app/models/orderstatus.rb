class Orderstatus < ActiveRecord::Base
   set_table_name "OrderStatus"
  set_primary_key "OrderStatusId"

 has_many :Histories, :foreign_key => :OrderStatusId
 has_many :Rords, :foreign_key => :OrderStatusId
 has_many :Orders, :foreign_key => :OrderStatusId
 
end
