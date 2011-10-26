class Address < ActiveRecord::Base
      set_table_name "Addresses"
  set_primary_key "AddressId"
   has_many :Properties, :foreign_key => "AddressId"
   belongs_to :Taxrate, :foreign_key => "StateId"
   
 end
