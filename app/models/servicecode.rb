class Servicecode < ActiveRecord::Base
     set_table_name "ServiceCodes"
  set_primary_key "ServiceCodeId"
has_many :Orders, :foreign_key => :ServiceCodeId
  has_many :Rords, :foreign_key => :ServiceCodeId
  has_many :Histories, :foreign_key => :ServiceCodeId


end