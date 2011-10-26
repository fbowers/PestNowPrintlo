class Route < ActiveRecord::Base
       set_table_name "Routes"
  set_primary_key "RouteId"

# has_many :Rubyroutes,  :foreign_key => :RouteId
  has_many :Userroutes,  :foreign_key => :RouteId
has_many :Users, :through => :Userroutes#, :foreign_key => :RouteId, :association_foreign_key => :UserId


  has_many :Scheduleroutes, :foreign_key => :RouteId
  has_many :Schedules, :through => :Scheduleroutes
 # has_many :Rords, :through => :Scheduleroutes
  

  

end

