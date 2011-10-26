class Contract < ActiveRecord::Base
   set_table_name "Contracts"
  set_primary_key "ContractId"

 belongs_to :Property, :foreign_key => :PropertyId
 belongs_to :Contracttype, :foreign_key => :ContractTypeId
 belongs_to :Order, :foreign_key => :OriginatingOrderId
belongs_to :User, :foreign_key => :SoldBy
belongs_to :Frequency, :foreign_key => :FrequencyId

has_many :Contractpests,  :foreign_key => :ContractId
  has_many :Pests, :through => :Contractpests
end