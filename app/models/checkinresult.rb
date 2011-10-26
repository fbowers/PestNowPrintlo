class Checkinresult < ActiveRecord::Base
    set_table_name "rcheckinresults"
  set_primary_key "CheckInResultId"

  has_many :Orders, :foreign_key => :CheckInResultId


end
