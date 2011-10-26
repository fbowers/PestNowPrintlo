class Windspeed< ActiveRecord::Base
   set_table_name "WindSpeed"
  set_primary_key "WindSpeedId"


   has_many :Orders, :foreign_key => :WindSpeedId


end
