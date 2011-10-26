class Checklistitem < ActiveRecord::Base
    set_table_name "CheckListItems"
  set_primary_key "CheckListItemId"


  has_many :Orderchecklistitems, :foreign_key => :CheckListItemId
  has_many :Orders,  :through => :Orderchecklistitems

end
