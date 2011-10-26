class PaymentsController < ApplicationController
#layout 'orderpads'
  layout 'public'
  helper :authorize_net
#  protect_from_forgery :except => :relay_response

skip_before_filter :verify_authenticity_token 

  def payment
     @id = params[:id]
    @order = Order.find(params[:id])
    @amount = params[:amount]
   # @amount = 10.00
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => 'http://205.232.183.148:443/payments/receipt')
 # @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => 'http://216.177.62.21:443/payments/receipt', [x_card_num] => @cardnumber, [x_exp_date] => '0914')
  if response.success? and response.authorization
    @custledger = Customerledger.new()
    @custledger.update_attributes(:InsertTime => Time.now, :PaymentType => 'CreditCard', :CCType => @cardtype, :CCNumber => @number, :Deposit => @amount, :Active => 1, :PropertyId => @orderid, :UpdateUserId => 1, :EntryDate => Time.now, :UpdateTime => Time.now, :UpdateReason => "CC Entry From Road App", :CCAuthNumber => response.authorization)
  
 #     update_attributes({:confirmation_id => response.authorization})
      return true
    else
        render :text => 'Sorry, we failed to validate your response. Please check that your "Merchant Hash Value" is set correctly in the config/authorize_net.yml file.'

 #     update_attributes({:error => !response.success?,
  #                       :error_code => response.params['messages']['message']['code'],
   #                      :error_message => response.params['messages']['message']['text']})
      return false
    end

  end

def autopay
  @cardnumber = 4111111111111111
  @amount = params[:amount]
   # @amount = 10.00
   @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => 'http://205.232.183.148:443/payments/receipt', [x_card_num] => @cardnumber, [x_exp_date] => '0914')
   end

  # POST
  # Returns relay response when Authorize.Net POSTs to us.
  def relay_response
    sim_response = AuthorizeNet::SIM::Response.new(params)
    if sim_response.success?(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['merchant_hash_value'])
      render :text => sim_response.direct_post_reply(payments_receipt_url(:only_path => false), :include => true)
    
    else
      render
    end
  end

  # GET
  # Displays a receipt.
  def receipt

    sim_response = AuthorizeNet::SIM::Response.new(params)
    if sim_response.valid_md5?(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['merchant_hash_value'])
      @transaction_id = sim_response.transaction_id
        
    else
      render :text => 'Sorry, we failed to validate your response. Please check that your "Merchant Hash Value" is set correctly in the config/authorize_net.yml file.'
    end

   
  


 #   @auth_code = params[:x_auth_code]
 #   @orderid = params[:x_invoice_num]
 #   @amount = params[:x_amount]
 #   @number = params[:x_account_number]
 #   @cardtype = params[:x_card_type]
 #   @reason = params[:x_response_reason_text]
 #   @code = params[:x_response_code]
   
 #     if @code == '1'

 #   @custledger = Customerledger.new()
 #   @custledger.update_attributes(:InsertTime => Time.now, :PaymentType => 'CreditCard', :CCType => @cardtype, :CCNumber => @number, :Deposit => @amount, :Active => 1, :PropertyId => @orderid, :UpdateUserId => 1, :EntryDate => Time.now, :UpdateTime => Time.now, :UpdateReason => "CC Entry From Road App", :CCAuthNumber => @auth_code)
 #   @custledgerorder = Customerledgerorder.new(:LedgerId => @custledger.LedgerId)
 #   @custledgerorder.update_attributes(:OrderId => @orderid, :Deposit => @amount, :InsertTime => Time.now,  :InsertUserId => 1, :UpdateTime => Time.now, :UpdateUserId => 1, :UpdateReason => "CC Entry From Road App")
    
 #   else
 #     flash[:notice] = "Error"
 # end
  end
  def payment_process
amount_to_charge = 10 #ten US dollars
ActiveMerchant::Billing::Base.mode = :test
#ActiveMerchant::Billing::CreditCard.require_verification_value = :false

creditcard = ActiveMerchant::Billing::CreditCard.new(
:number => '4743021568285472', #Authorize.net test card, error-producing
#:verification_value => '123',
#:verification_value => '567',
:month => 8, #for test cards, use any date in the future
:year => 2018,
:first_name => 'test',
:last_name => 'user',
:type => 'VISA'
)

if creditcard.valid?
gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
#ActiveMerchant::Billing::Base.gateway(:authorized_net).new(
:login =>'9dhEyE46F', # API Login ID
:password =>'4r5dM89Y3HJr4R4s') #Transaction Key

response = gateway.authorize(amount_to_charge*100 , creditcard ,
:billing_address =>{ :name =>'Mark
McBride',:address1 => '1 Show Me The Money
Lane',:city => 'San Francisco',:state =>
'CA',:country => 'US',:zip => '23456',:phone =>
'(555)555-5555'})

if response.success?
gateway.capture(amount_to_charge, response.authorization)
render :text => 'Success:' + response.message.to_s and return
else
render :text => 'Fail:' + response.message.to_s and return
end
else
render :text =>'Credit card not valid: ' + creditcard.validate.to_s
#end return
end

  end



end
