class Rsettlement < ActiveRecord::Base
    set_table_name "rsettlements"
  set_primary_key "SettlementCompanyId"

  has_many :Orders, :foreign_key => "SettlementCompanyId"
  has_many :Rords, :foreign_key => "SettlementCompanyId"
  

end