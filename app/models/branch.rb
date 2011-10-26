class Branch < ActiveRecord::Base
  set_table_name "Branches"
  set_primary_key "BranchId"
  
  has_many :Orders, :foreign_key => :BranchId
  has_many :Rords, :foreign_key => :BranchId

  
end
