class Order < ActiveRecord::Base
   set_table_name "Orders"
  set_primary_key "OrderId"
  
 # validates :Temperature, :numericality => true
 #  validates :AreaTreated, :presence => true
 #  validates :CheckComments, :presence => true

 belongs_to :Property, :foreign_key => :PropertyId
 belongs_to :Servicecode, :foreign_key => :ServiceCodeId
 belongs_to :Branch, :foreign_key => :BranchId
 belongs_to :Schedule, :foreign_key => :ScheduleId
belongs_to :Customer, :foreign_key => :CustomerId
accepts_nested_attributes_for :Customer
belongs_to :Rbillcustomer, :foreign_key => :BillingCustomerId
belongs_to :Owner, :foreign_key => :BillingCustomerId
belongs_to :Orderstatus, :foreign_key => :OrderStatusId
 belongs_to :Rsettlement, :foreign_key => :SettlementCompanyId
 belongs_to :Ragent, :foreign_key => :AgentId
#has_many :Contracts, :foreign_key => :OriginatingOrderId
   has_one :Contract, :foreign_key => :OriginatingOrderId

has_many :WDIs, :foreign_key => :OriginatingOrderId
  belongs_to :Warranty, :foreign_key => :WarrantyId
   has_many :Customerledgerorders, :foreign_key => :OrderId
   has_many :Clos, :foreign_key => :OrderId
  has_many :Customerledgers,  :through => :Customerledgerorders
has_many :Userledgers, :foreign_key => :OrderId
  has_many :Orderchecklistitems, :foreign_key => :OrderId
  has_many :Checklistitems,  :through => :Orderchecklistitems
  belongs_to :Checkinresult, :foreign_key => :CheckInResultId
 # belongs_to :User, :foreign_key => :SoldBy
belongs_to :Usercommissionrate, :foreign_key => :ServiceCodeId
belongs_to :Usercommissionrate, :foreign_key => :SoldBy

  has_many :Orderchemicals, :foreign_key => :OrderId
   # accepts_nested_attributes_for :Orderchemicals
  has_many :Chemicals,  :through => :Orderchemicals


  
  

  has_many :Orderequipments, :foreign_key => :OrderId
  has_many :Equipments,  :through => :Orderequipments

  

  has_many :Orderpests,  :foreign_key => :OrderId
  has_many :Pests, :through => :Orderpests


 belongs_to :Temperature, :foreign_key => :TemperatureId
 belongs_to :Weather, :foreign_key => :WeatherId
 belongs_to :Wind, :foreign_key => :WindId
 belongs_to :Windspeed, :foreign_key => :WindSpeedId

has_many :Ordercheckcomments,  :foreign_key => :OrderId
  has_many :Checkcomments, :through => :Ordercheckcomments

  has_many :Orderareas,  :foreign_key => :OrderId
  has_many :Areatreateds, :through => :Orderareas



#  def self.dayschedule
#  find(:all, :joins => [:Servicecode, :Orderstatus, :Schedule => :Scheduleroutes, :Property => :Address],:conditions => ["Orders.OrderStatusId != 4 AND ScheduleRoutes.RouteId = ? AND StartTime BETWEEN ? AND ?" ,
# params[@hope],'9/20/11', '9/21/11'])
#
#end



end
