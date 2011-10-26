class Weather< ActiveRecord::Base
   set_table_name "Weather"
  set_primary_key "id"


      has_many :Orders, :foreign_key => :WeatherId


end
