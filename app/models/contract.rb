class Contract < ActiveRecord::Base
   set_table_name "Contracts"
  set_primary_key "ContractId"

#  before_save :default_values
#def default_values

 # self.InsertTime = Time.now
 # self.DateEntered = Time.now
 # self.InsertUserId = 'current_user.UserId'
 #  self.ContractTypeId = '1'
#end


 belongs_to :Property, :foreign_key => :PropertyId
 belongs_to :Contracttype, :foreign_key => :ContractTypeId
 belongs_to :Order, :foreign_key => :OrderId
belongs_to :User, :foreign_key => :SoldBy
belongs_to :Frequency, :foreign_key => :FrequencyId


has_many :Contractpests,  :foreign_key => :ContractId
  has_many :Pests, :through => :Contractpests

#  accepts_nested_attributes_for :Contractpests

#def update_attributes(attributes)
 # self.OneTimePrice = 2500
 # self.attributes = attributes
   # self.Covered = 1
   
 # end



end
