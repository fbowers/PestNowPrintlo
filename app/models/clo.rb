class Clo< ActiveRecord::Base

  set_table_name  "Bulk_ExportStatementWeeklyAll"


   belongs_to :Order, :foreign_key => :OrderId
 belongs_to :Customerledger, :foreign_key => :LedgerId



end
