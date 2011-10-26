class Customerledger< ActiveRecord::Base
   set_table_name "CustomerLedgers"
  set_primary_key "LedgerId"

   has_many :Customerledgerorders, :foreign_key => :LedgerId
  has_many :Orders,  :through => :Customerledgerorders


 




end
