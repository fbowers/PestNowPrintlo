class Userroute < ActiveRecord::Base
       set_table_name "UserRoutes"
  set_primary_key "UserRouteId"


  belongs_to :User, :foreign_key => :UserId
 belongs_to :Route,  :foreign_key => :RouteId



   def self.activeroute
    find(:all, :conditions => ["Active= 1 AND EndTime > ? ", Time.now.midnight-1.day])
   end

  

end