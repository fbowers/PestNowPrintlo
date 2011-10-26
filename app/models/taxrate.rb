class Taxrate < ActiveRecord::Base
       set_table_name "TaxRates"
  set_primary_key "StateCode"

has_one :Address, :foreign_key => :StateCode

end
