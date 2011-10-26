class Contractpest < ActiveRecord::Base
     set_table_name "ContractPests"
  set_primary_key "ContractId"

before_save :default_values
def default_values
  self.Covered = '1'
  self.InsertTime = Time.now
  self.InsertUserId = 'current_user.UserId'
  
end



# has_one :Contract, :foreign_key => :ContractId
belongs_to :Contract, :foreign_key => :ContractId
belongs_to :Pest, :foreign_key => :PestId



  
end
  # def initialize(params = nil) self.Covered = 1 end
 #property :Covered, :default => "1"

 
