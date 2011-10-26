class Customerledgerhistory< ActiveRecord::Base
   set_table_name "CustomerLedgerHistory"
  set_primary_key "LedgerHistoryId"

   has_many :Customerledgerorders, :foreign_key => :LedgerId
  has_many :Orders,  :through => :Customerledgerorders







end
