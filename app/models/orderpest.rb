class Orderpest < ActiveRecord::Base
     set_table_name "OrderPests"
  set_primary_key "OrderId"


   belongs_to :Order, :foreign_key => :OrderId
   belongs_to :Pest, :foreign_key => :PestId

  
end