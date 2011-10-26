class Rubyroute < ActiveRecord::Base
    set_table_name "rubyroutes"

     set_primary_key "RouteId"

 
#has_many :Users, :foreign_key => :UserId


 # has_many :Scheduleroutes, :foreign_key => :RouteId
 # has_many :Schedules, :through => :Scheduleroutes
 



end