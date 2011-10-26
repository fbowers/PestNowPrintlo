class Wind< ActiveRecord::Base
   set_table_name "Wind"
  set_primary_key "WindId"


    has_many :Orders, :foreign_key => :WindId

  end