class Usercommissionrate < ActiveRecord::Base
   # set_table_name "rusercommissionrate"
   set_table_name "UserCommissionRates"
  set_primary_key "UserId"

belongs_to :User, :foreign_key => :UserId
belongs_to :ServiceCode, :foreign_key => :ServiceCodeId
has_many :Orders, :foreign_key => :ServiceCodeId
has_many :Orders, :foreign_key => :SoldBy

end
