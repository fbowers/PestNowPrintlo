class Ordercheckcomment< ActiveRecord::Base
   set_table_name "OrderCheckComment"
  set_primary_key "OrderCheckCommentId"


   belongs_to :Order, :foreign_key => :OrderId
   belongs_to :Checkcomment, :foreign_key => :CheckCommentId


end