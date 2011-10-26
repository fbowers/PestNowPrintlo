class Owner < ActiveRecord::Base
    set_table_name "Customers"
  set_primary_key "CustomerId"
  has_many :Properties, :foreign_key => "OwnerId"
  has_many :Orders, :foreign_key => "BillingCustomerId"
   has_many :Rords, :foreign_key => "BillingCustomerId"
end
