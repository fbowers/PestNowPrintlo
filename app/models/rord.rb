class Rord < ActiveRecord::Base
   set_table_name "rord"
  set_primary_key "OrderId"

 belongs_to :Property, :foreign_key => :PropertyId
 belongs_to :Servicecode, :foreign_key => :ServiceCodeId
 belongs_to :Branch, :foreign_key => :BranchId

belongs_to :Customer, :foreign_key => :CustomerId
belongs_to :Rbillcustomer, :foreign_key => :BillingCustomerId
belongs_to :Owner, :foreign_key => :BillingCustomerId
belongs_to :Orderstatus, :foreign_key => :OrderStatusId
 belongs_to :Rsettlement, :foreign_key => :SettlementCompanyId
 belongs_to :Ragent, :foreign_key => :AgentId

end