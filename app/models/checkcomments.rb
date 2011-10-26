class Checkcomment< ActiveRecord::Base
   set_table_name "CheckComments"
  set_primary_key "CheckCommentId"


   has_many :Orders, :foreign_key => :CheckCommentId



end