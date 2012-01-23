class Pest < ActiveRecord::Base
     set_table_name "railspest"
  #set_primary_key "PestId"

  #has_one :Contractpest,  :foreign_key => :PestId
  #has_one :Contract, :through => :Contractpest


  has_many :Contractpests,  :foreign_key => :PestId
  has_many :Contracts, :through => :Contractpests

 # has_many :Orderpests,  :foreign_key => :PestId
 # has_many :Orders, :through => :Orderpests
  has_many :Orders, :foreign_key => :PestId




end