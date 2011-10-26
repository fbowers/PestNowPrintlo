class WDI < ActiveRecord::Base
   set_table_name "WDIs"
  set_primary_key "WDIId"

 belongs_to :Order, :foreign_key => :OriginatingOrderId
 belongs_to :User, :foreign_key => :OriginatingUserId
# belongs_to :Warranty, :foreign_key => :OriginatingOrderId
 




end
