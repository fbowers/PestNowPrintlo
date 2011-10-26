class Temperature< ActiveRecord::Base
   set_table_name "Temperature"
  set_primary_key "TemperatureId"


   has_many :Orders, :foreign_key => :TemperatureId



end