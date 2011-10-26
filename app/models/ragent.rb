class Ragent < ActiveRecord::Base
    set_table_name "ragents"
  set_primary_key "AgentId"

  has_many :Orders, :foreign_key => "AgentId"
  has_many :Rords, :foreign_key => "AgentId"
  

end