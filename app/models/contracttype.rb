class Contracttype < ActiveRecord::Base
   set_table_name "railscontracttypes"
  set_primary_key "ContractTypeId"


 has_many :Contracts,  :foreign_key => :ContractTypeId

end