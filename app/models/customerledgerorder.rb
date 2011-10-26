class Customerledgerorder< ActiveRecord::Base
# set_table_name "CustomerLedgerOrders"
set_table_name  "railscustomerledgerorders"
# set_primary_key :LedgerId
#set_primary_key :OrderId

#  validates_uniqueness_of :OrderId

 belongs_to :Order, :foreign_key => :OrderId
 belongs_to :Customerledger, :foreign_key => :LedgerId
 belongs_to :Customerledgerhistory, :foreign_key => :LedgerId
# belongs_to :Warranty, :foreign_key => :OriginatingOrderId
# attr_accessible :LedgerId
# attr_accessible :OrderId
# attr_accessible :Charge
# attr_accessible :Deposit
# attr_accessible :TaxCharge
# attr_accessible :TaxRate
# attr_accessible :InsertTime
# attr_accessible :InsertUserId
# attr_accessible :UpdateTime
# attr_accessible :UpdateUserId
# attr_accessible :UpdateReason

 




end
