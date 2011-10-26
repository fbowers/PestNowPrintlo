class Ruser < ActiveRecord::Base
       set_table_name "ruser"
  set_primary_key "UserId"

#acts_as_authentic do |c|
    #c.login_field = Username

   #c.crypted_password_field = Pass
   # config.crypto_provider = YourCryptoProvider
   #  end

end