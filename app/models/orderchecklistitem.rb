class Orderchecklistitem < ActiveRecord::Base
    set_table_name "OrderCheckListItems"
  set_primary_key "OrderId"

  belongs_to :Order, :foreign_key => :OrderId
belongs_to :Checklistitem, :foreign_key => :CheckListItemId
attr_accessible :OrderId
attr_accessible :CheckListItemId
attr_accessible :InsertTime
attr_accessible :InsertUserId
attr_accessible :CheckListItemId
attr_accessible :Optional
attr_accessible :DateCompleted
attr_accessible :UpdateUserId
attr_accessible :UpdateTime
attr_accessible :IsComplete
attr_accessible :Ignore

end
