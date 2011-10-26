class Areatreated< ActiveRecord::Base
   set_table_name "AreaTreated"
  set_primary_key "AreaTreatedId"

 
has_many :Orderareas,  :foreign_key => :AreaTreatedId
  has_many :Orders, :through => :Orderareas

end