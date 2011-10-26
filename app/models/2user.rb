class User < ActiveRecord::Base
       set_table_name "Users"
  set_primary_key "UserId"
 

  has_many :Userroutes, :foreign_key => :UserId
  has_many :Routes,  :through => :Userroutes
  has_many :Contracts, :foreign_key => :SoldBy

 
acts_as_authentic do |c|
    c.login_field = Username
    c.crypted_password_field = Pass
   # config.crypto_provider = YourCryptoProvider
     end

    #
    #
#has_and_belongs_to_many "Routes",
#  :join_table => "UserRoutes",
#     :foreign_key => "UserId",
#   :association_foreign_key => "RouteId"
end
