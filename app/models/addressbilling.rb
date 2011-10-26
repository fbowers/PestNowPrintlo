class Addressbilling < ActiveRecord::Base
      set_table_name "Addresses"
  set_primary_key "AddressId"
   has_many :Billcustomers, :foreign_key => "AddressId"
  
 end
