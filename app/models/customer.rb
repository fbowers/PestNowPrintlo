class Customer < ActiveRecord::Base
    set_table_name "Customers"
  set_primary_key "CustomerId"
  has_many :Properties, :foreign_key => "CustomerId"
  has_many :Orders, :foreign_key => "CustomerId"
  has_many :Rords, :foreign_key => "CustomerId"
end
