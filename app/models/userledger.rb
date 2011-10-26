class Userledger < ActiveRecord::Base
    set_table_name "UserLedgers"
  set_primary_key "LedgerId"

  belongs_to :Order, :foreign_key => :OrderId
belongs_to :User, :foreign_key => :UserId

end
