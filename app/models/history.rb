  class History < ActiveRecord::Base
   set_table_name "Orders"
  set_primary_key "OrderId"


belongs_to :Property, :foreign_key => :PropertyId
 belongs_to :Servicecode, :foreign_key => :ServiceCodeId
 belongs_to :Branch, :foreign_key => :BranchId
 belongs_to :Schedule, :foreign_key => :ScheduleId
belongs_to :Customer, :foreign_key => :CustomerId
belongs_to :Owner, :foreign_key => :BillingCustomerId
belongs_to :Orderstatus, :foreign_key => :OrderStatusId
accepts_nested_attributes_for :Schedule
end
