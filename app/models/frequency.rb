class Frequency < ActiveRecord::Base
   set_table_name "Frequencies"
  set_primary_key "FrequencyId"


 has_many :Contracts,  :foreign_key => :FrequencyId

end