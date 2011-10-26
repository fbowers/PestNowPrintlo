class Checkcomment< ActiveRecord::Base
   set_table_name "CheckComments"
  set_primary_key "CheckCommentId"


has_many :Ordercheckcomments,  :foreign_key => :CheckCommentId
  has_many :Orders, :through => :Ordercheckcomments
end