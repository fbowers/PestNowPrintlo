class Rbillcustomer < ActiveRecord::Base
    set_table_name "rbillcustomers"
  set_primary_key "BillingCustomerId"
has_many :Rords, :foreign_key => "BillingCustomerId"
  has_many :Orders, :foreign_key => "BillingCustomerId"
  belongs_to :Addressbilling, :foreign_key => :AddressId

end