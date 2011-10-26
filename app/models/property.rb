class Property < ActiveRecord::Base
    set_table_name "Properties"
  set_primary_key "PropertyId"
belongs_to :Address, :foreign_key => :AddressId
belongs_to :Customer, :foreign_key => :CustomerId
belongs_to :Owner, :foreign_key => :OwnerId
has_many :Rords, :foreign_key => :PropertyId
has_many :Warranties, :foreign_key => :PropertyId, :order=>'WarrantyId DESC', :limit => 5
has_many :Orders, :foreign_key => :PropertyId
has_many :Contracts, :foreign_key => :PropertyId, :order=>'ContractId DESC', :limit => 5
has_many :Histories, :foreign_key => :PropertyId, :order=>'OrderId DESC'



  accepts_nested_attributes_for :Histories


  
end


