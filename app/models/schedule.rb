class Schedule < ActiveRecord::Base
   set_table_name "Schedules"
  set_primary_key "ScheduleId"

#has_many :Orders, :foreign_key => :ScheduleId
has_one :Order, :foreign_key => :ScheduleId
has_many :Histories, :foreign_key => :ScheduleId

has_many :Scheduleroutes, :foreign_key => :ScheduleId
    has_many :Routes, :through => :Scheduleroutes
 

#def self.dayschedule
#  find(:all, :joins => [:Scheduleroutes, :Order => :Property ],:conditions => ["ScheduleRoutes.RouteId = ? AND StartTime BETWEEN ? AND ?" ,
#123, '9/20/11', '9/21/11'])
#
#end

  
end
