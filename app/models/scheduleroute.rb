class Scheduleroute < ActiveRecord::Base
     set_table_name "ScheduleRoutes"
  set_primary_key "ScheduleRouteId"

#belongs_to :Rord, :foreign_key => :ScheduleId
 belongs_to :Schedule, :foreign_key => :ScheduleId
 belongs_to :Route,  :foreign_key => :RouteId
 
end