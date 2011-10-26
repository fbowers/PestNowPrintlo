class User < ActiveRecord::Base
       set_table_name "ruser"
  set_primary_key "UserId"

  has_many :Userroutes, :foreign_key => :UserId
    has_many :Routes,  :through => :Userroutes
  has_many :Contracts, :foreign_key => :SoldBy
  has_one :WDI, :foreign_key => :OriginatingUserId
  has_many :Userledgers, :foreign_key => :UserId
  has_one :Usercommissionrate, :foreign_key => :UserId
  # has_many :Orders, :foreign_key => :SoldBy
acts_as_authentic
    #c.login_field = Username

   #c.crypted_password_field = Pass
   # config.crypto_provider = YourCryptoProvider
   #  end

end