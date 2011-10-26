    class PrintingController < ApplicationController

respond_to :html, :xml, :json
helper :authorize_net
 # layout "orderpads", :except => :workvoice
  def index

  end

   def workvoice
@id = params[:id]
    @order = Order.find(params[:id])
  ##  @amount = @balance
    #@amount = 10.00
   
@oid = Order.find(params[:id])
@inv = Order.includes(:Schedule, :Servicecode,  :Property, :Customer, :Customerledgerorders).find(@oid)

@noteby = @inv.Userledgers.where("Note = 'Serv'")
@presum = Order.find(:all,
  :conditions => ["OrderCopiedFrom = ?", @oid])
@balance = @inv.Customerledgerorders.sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
@taxsum = @inv.Customerledgerorders.sum("TaxCharge")
@sub = @inv.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
# @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @balance, :relay_url => 'http://216.177.62.21:443/payments/receipt')

    respond_to do |format|
      format.html # index.html.erb
    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/workorder.pdf', :document_content => render_to_string, :document_type => "pdf", :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'workorder.pdf'
    end

    end
  end

   def cc
@gg = params[:gg]|| 11
@em = params[:em]|| 11
#@t2 = params[:t2]|| 22

      @order = Order.find(params[:id])
   @con = @order.Property

      @con.update_attributes(:GoGreen => @gg)
   
     @email = @order.Property.Customer
      @email.update_attributes(:Email => @em)
     
#    respond_to do |format|
respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @homepages }
       format.js
        format.json
    end
      #if @orderpad.update_attributes(params[:x1])
        #format.html { redirect_to(@orderpad, :notice => 'Orderpad was successfully updated.') }
        #format.html :notice => 'Orderpad was successfully updated.'
       # format.xml  { head :ok }
       # format.js

     # else
    #    format.html #{ render :action => "edit" }
     #   format.xml  { render :xml => @orderpad.errors, :status => :unprocessable_entity }
    #   format.js

#      end
 #   end

    end

   def sendfile4inch
@id = params[:id]
@order = Order.find(params[:id])
@oid = Order.find(params[:id])


#@oid = Order.find(1412690)
#@id = '1412690'
#@order = Order.find(1412690)

#@oid = Order.find(:id)
@inv = Order.includes(:Schedule, :Servicecode,  :Property, :Customer, :Customerledgerorders).find(@oid)
@noteby = @inv.Userledgers.where("Note = 'Serv'")
@presum = Order.find(:all,
  :conditions => ["OrderCopiedFrom = ?", @oid])
@balance = @inv.Customerledgerorders.sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
@taxsum = @inv.Customerledgerorders.sum("TaxCharge")
@sub = @inv.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
      @branches = Branch.find(:all)
     # @branch2 = "fred"
      @orderpads = Order.limit(10).includes(:Schedule).where("Schedules.StartTime =  3/22/2011").to_s
   @OrderId=@inv.OrderId.to_s
   @Date = @inv.Schedule.StartTime.strftime("%m/%d/%y").to_s
   @PropId=@inv.PropertyId.to_s
@Custname = @inv.Customer.FirstName.to_s + " " + @inv.Customer.LastName.to_s
@Custstreet= @inv.Property.Address.StreetNumber.to_s + @inv.Property.Address.Direction.to_s + " " + @inv.Property.Address.Street.to_s
@Custcsz= @inv.Property.Address.City.to_s + ", " + @inv.Property.Address.StateId.to_s + " " + @inv.Property.Address.ZipCodeId.to_s
@Custphone= @inv.Customer.Email.to_s + " " +@inv.Customer.Phone1.to_s + " " + @inv.Customer.Phone2.to_s
@Tax = @taxsum.to_s
@Due = @balance.to_s

@Tempname =  @inv.Temperature.name.to_s ||
#@ti = @inv.TimeIn.strftime("%I:%M %p").to_s
@ti = @inv.Schedule.StartTime.strftime("%m/%d/%y").to_s
@xid = @inv.TimeIn.strftime("%I:%M %p").to_s
@Weather = @inv.Weather.name.to_s
@Wind = @inv.Wind.name.to_s
@Windspeed = @inv.Windspeed.name.to_s
@Note = @inv.WorkOrderNote.to_s



      data =

"! 0 200 200 2000 1\r\n" + "
PW 615\r\n" + "
CONTRAST 0\r\n" + "
TONE 0\r\n" + "
SPEED 5\r\n" + "
ON-FEED IGNORE\r\n" + "
NO-PACE\r\n" + "
BAR-SENSE\r\n" + "
;// PAGE 0000000003800240\r\n" + "
T 5 2 25 0 Work Order" + "\r\n" + "
T 5 2 25 60 PestNow.com" + "\r\n" + "
T 5 0 281 0 Time In: " + @xid +"\r\n" + "
T 5 0 281 30 Temperature: " + @Tempname +"\r\n" + "
T 5 0 281 60 Weather: " + @Weather +"\r\n" + "
T 5 0 281 90 Wind: " + @Wind +"\r\n" + "
T 5 0 281 120 Wind Speed: " + @Windspeed +"\r\n" + "
T 5 0 25 150 Account Information" +"\r\n" + "
IL 0 150 615 150 30\r\n" + "
T 5 0 25 200 Date: " + "\r\n" + "
T 5 0 281 200 " + @Date +"\r\n" + "
T 5 0 25 230 Account Number: " +"\r\n" + "
T 5 0 281 230 " + @PropId +"\r\n" + "
T 5 0 25 260 InvoiceNumber: " + "\r\n" + "
T 5 0 281 260 " + @OrderId +"\r\n" + "
T 5 0 25 290 Service Property: " +"\r\n" + "
T 5 0 281 290 " + @Custname +"\r\n" + "
T 5 0 281 320 " + @Custstreet +"\r\n" + "
T 5 0 281 350 " + @Custcsz +"\r\n" + "
T 5 0 281 380 " + @Custphone +"\r\n" + "
T 5 0 25 410 Customer Service: " + "\r\n" + "
T 5 0 281 410 877.284.2466" + "\r\n" + "
T 5 0 25 440 Hours of Operation: " + "\r\n" + "
T 5 0 281 440 M-F 7:30-6 Sat 8-12" + "\r\n" + "
T 5 0 25 470 Website Address: " + "\r\n" + "
T 5 0 281 470 www.pestnow.com " + "\r\n" + "
T 5 0 25 500 Tax: " + "\r\n" + "
T 5 0 281 500 $" + @Tax +"\r\n" + "
T 5 0 25 530 Amount Due: " +"\r\n" + "
T 5 0 281 530 $" + @Due +"\r\n" + "
CENTER" +"\r\n" + "
T 5 0 25 560 Questions?/Comments?/Concerns?"+"\r\n" + "
T 5 0 25 590 preeves@pestnow.com"+"\r\n" + "
LEFT" +"\r\n" + "
T 5 0 25 640 Transactions" +"\r\n" + "
T 5 0 25 670 Date         Description                             Amount" +"\r\n" + "
IL 0 640 615 640 25\r\n" + "
T 5 0 25 780 Work Orders Details" +"\r\n" + "
IL 0 780 615 780 25\r\n" + "
T 5 0 25 820 Area Treated" + "\r\n" + "
IL 0 820 275 820 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 25 850\r\n"
 @inv.Areatreateds.each do |at|
 data << at.name + "\r\n"
      end

data <<  "ENDML\r\n" + "
T 5 0 25 970 Equipment Used" + "\r\n" + "
IL 0 970 275 970 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 25 1000\r\n"
 @inv.Equipments.each do |e|
     data << e.name + "\r\n"
 end

data <<  "ENDML\r\n" + "

T 5 0 281 820 Target Pests" + "\r\n" + "
IL 281 820 615 820 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 281 850\r\n"
 @inv.Pests.each do |p|
     data << p.name + "\r\n"
 end

data <<  "ENDML\r\n" + "


T 5 0 5 1100 Chemicals Used" + "\r\n" + "
IL 0 1100 615 1100 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 5 1130\r\n"
 @inv.Orderchemicals.each do |c|
     data << c.Chemical.name + " %" + c.Chemical.Percentage + " EPA#" + c.Chemical.EPANumber + " " + c.Quantity.to_s + " " +c.Chemical.Measurement + "\r\n"
 end

data <<  "ENDML\r\n" + "

T 5 0 25 1300 Work Order Notes" + "\r\n" + "
IL 0 1300 615 1300 25\r\n" + "
T 5 0 25 1330 Thanks for your business. It was a pleasure." + "\r\n" + "
T 5 0 25 1360 " + @Note +"\r\n" + "
ML 27\r\n" + "
TEXT 5 0 25 1390\r\n"
 @inv.Checkcomments.each do |cc|
     data << cc.name + "\r\n"
 end
data <<  "ENDML\r\n" + "


T 5 0 25 1500 Your Technician(s) were" + "\r\n" + "
ML 27\r\n" + "
TEXT 5 0 25 1530\r\n"
 @inv.Userledgers.each do |u|
     data << u.User.FirstName + " " + u.User.CertificationNumber + "\r\n"
 end
data <<  "ENDML\r\n" + "
CENTER" +"\r\n" + "
T 5 2 25 1750 Send Payments to" + "\r\n" + "
T 5 1 25 1800 PestNow" + "\r\n" + "
T 5 1 25 1850 PO Box 2210 Ashburn, VA 20146" + "\r\n" + "
LEFT" +"\r\n" + "
ML 27\r\n" + "
TEXT 5 0 25 700\r\n"
 @sub.each do |x|
     data << x.Order.Schedule.StartTime.strftime("%m/%d/%y") + " " + x.Order.Servicecode.Description + " $" + x.Charge.to_s + " pd$" + x.Deposit.to_s + "\r\n"
#       <tr> <td> <%= x.Order.Schedule.StartTime.strftime("%m/%d/%y") %>   </td>
   #    <td> <%#= x.Order.OrderId %>   </td>
#       <td> <%= x.Order.Servicecode.Description %>   </td>
 #      <td> <%#= number_to_currency(x.Charge)%>   pd<%= number_to_currency(x.Deposit)%> </td></tr>

 end

data <<  "ENDML\r\n"

#   data << "FORM\r\n"
data <<   "PRINT\r\n"



send_data( data, :filename => @id+".LBL" )
   end

   def sendfile
@id = params[:id]
@order = Order.find(params[:id])
@oid = Order.find(params[:id])

  
#@oid = Order.find(1412690)
#@id = '1412690'
#@order = Order.find(1412690)

#@oid = Order.find(:id)
@inv = Order.includes(:Schedule, :Servicecode,  :Property, :Customer, :Customerledgerorders).find(@oid)
@noteby = @inv.Userledgers.where("Note = 'Serv'")
@presum = Order.find(:all,
  :conditions => ["OrderCopiedFrom = ?", @oid])
@balance = @inv.Customerledgerorders.sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
@taxsum = @inv.Customerledgerorders.sum("TaxCharge")
@sub = @inv.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
      @branches = Branch.find(:all)
     # @branch2 = "fred"
      @orderpads = Order.limit(10).includes(:Schedule).where("Schedules.StartTime =  3/22/2011").to_s
   @OrderId=@inv.OrderId.to_s
   @Date = @inv.Schedule.StartTime.strftime("%m/%d/%y").to_s
   @PropId=@inv.PropertyId.to_s
@Custname = @inv.Customer.FirstName.to_s + " " + @inv.Customer.LastName.to_s
@Custstreet= @inv.Property.Address.StreetNumber.to_s + @inv.Property.Address.Direction.to_s + " " + @inv.Property.Address.Street.to_s
@Custcsz= @inv.Property.Address.City.to_s + ", " + @inv.Property.Address.StateId.to_s + " " + @inv.Property.Address.ZipCodeId.to_s
@Custphone= @inv.Customer.Email.to_s + " " +@inv.Customer.Phone1.to_s + " " + @inv.Customer.Phone2.to_s
@Tax = @taxsum.to_s
@Due = @balance.to_s

@Tempname =  @inv.Temperature.name.to_s || 
#@ti = @inv.TimeIn.strftime("%I:%M %p").to_s
@ti = @inv.Schedule.StartTime.strftime("%m/%d/%y").to_s
@xid = @inv.TimeIn.strftime("%I:%M %p").to_s
@Weather = @inv.Weather.name.to_s
@Wind = @inv.Wind.name.to_s
@Windspeed = @inv.Windspeed.name.to_s
@Note = @inv.WorkOrderNote.to_s



      data =

"! 0 200 200 2500 1\r\n" + "
PW 1000\r\n" + "
CONTRAST 0\r\n" + "
TONE 0\r\n" + "
SPEED 5\r\n" + "
ON-FEED IGNORE\r\n" + "
NO-PACE\r\n" + "
BAR-SENSE\r\n" + "
;// PAGE 0000000003800240\r\n" + "
T 5 2 0 0 Work Order" + "\r\n" + "
T 5 2 0 60 PestNow.com" + "\r\n" + "
T 5 0 255 0 Time In: " + @xid +"\r\n" + "
T 5 0 255 30 Temperature: " + @Tempname +"\r\n" + "
T 5 0 255 60 Weather: " + @Weather +"\r\n" + "
T 5 0 255 90 Wind: " + @Wind +"\r\n" + "
T 5 0 255 120 Wind Speed: " + @Windspeed +"\r\n" + "
T 5 0 0 150 Account Information" +"\r\n" + "
IL 0 150 300 150 30\r\n" + "
T 5 0 0 200 Date: " + "\r\n" + "
T 5 0 255 200 " + @Date +"\r\n" + "
T 5 0 0 230 Account Number: " +"\r\n" + "
T 5 0 255 230 " + @PropId +"\r\n" + "
T 5 0 0 260 InvoiceNumber: " + "\r\n" + "
T 5 0 255 260 " + @OrderId +"\r\n" + "
T 5 0 0 290 Service Property: " +"\r\n" + "
T 5 0 255 290 " + @Custname +"\r\n" + "
T 5 0 255 320 " + @Custstreet +"\r\n" + "
T 5 0 255 350 " + @Custcsz +"\r\n" + "
T 5 0 255 380 " + @Custphone +"\r\n" + "
T 5 0 0 410 Customer Service: " + "\r\n" + "
T 5 0 255 410 877.284.2466" + "\r\n" + "
T 5 0 0 440 Hours of Operation: " + "\r\n" + "
T 5 0 255 440 M-F 7:30-6 Sat 8-12" + "\r\n" + "
T 5 0 0 470 Website Address: " + "\r\n" + "
T 5 0 255 470 www.pestnow.com " + "\r\n" + "
T 5 0 0 500 Tax: " + "\r\n" + "
T 5 0 255 500 $" + @Tax +"\r\n" + "
T 5 0 0 530 Amount Due: " +"\r\n" + "
T 5 0 255 530 $" + @Due +"\r\n" + "
CENTER" +"\r\n" + "
T 5 0 25 560 Questions?/Comments?/Concerns?"+"\r\n" + "
T 5 0 25 590 preeves@pestnow.com"+"\r\n" + "
LEFT" +"\r\n" + "
T 5 0 0 620 Transactions" +"\r\n" + "
T 5 0 0 670 Date         Description                       Amount" +"\r\n" + "
IL 0 620 300 620 30\r\n" + "
T 5 0 0 780 Work Orders Details" +"\r\n" + "
IL 0 780 300 780 25\r\n" + "
T 5 0 0 820 Area Treated" + "\r\n" + "
IL 0 820 175 820 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 0 860\r\n"
 @inv.Areatreateds.each do |at|
 data << at.name + "\r\n"
      end

data <<  "ENDML\r\n" + "
T 5 0 0 970 Equipment Used" + "\r\n" + "
IL 0 970 275 970 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 0 1000\r\n"
 @inv.Equipments.each do |e|
     data << e.name + "\r\n"
 end

data <<  "ENDML\r\n" + "

T 5 0 281 820 Target Pests" + "\r\n" + "
IL 281 820 515 820 25\r\n" + "
ML 27\r\n" + "
TEXT 5 0 281 860\r\n"
 @inv.Pests.each do |p|
     data << p.name + "\r\n"
 end

data <<  "ENDML\r\n" + "


T 5 0 5 1400 Chemicals Used" + "\r\n" + "
IL 0 1400 300 1400 30\r\n" + "
ML 27\r\n" + "
TEXT 0 2 0 1440\r\n"
 @inv.Orderchemicals.each do |c|
     data << c.Chemical.name + " %" + c.Chemical.Percentage + " EPA#" + c.Chemical.EPANumber + " " + c.Quantity.to_s + " " +c.Chemical.Measurement + "\r\n"
 end

data <<  "ENDML\r\n" + "

T 5 0 0 1700 Work Order Notes" + "\r\n" + "
IL 0 1700 300 1700 30\r\n" + "
T 0 2 0 1740 Thanks for your business. It was a pleasure." + "\r\n" + "
T 0 2 0 1770 " + @Note +"\r\n" + "
ML 27\r\n" + "
TEXT 0 2 0 1800\r\n"
 @inv.Checkcomments.each do |cc|
     data << cc.name + "\r\n"
 end
data <<  "ENDML\r\n" + "


T 5 0 0 2100 Your Technician(s) were" + "\r\n" + "
ML 27\r\n" + "
TEXT 5 0 0 2130\r\n"
 @inv.Userledgers.each do |u|
     data << u.User.FirstName + " " + u.User.CertificationNumber + "\r\n"
 end
data <<  "ENDML\r\n" + "
CENTER" +"\r\n" + "
T 5 1 0 2170 Amount Due: " +"\r\n" + "
T 5 1 0 2210 $" + @Due +"\r\n" + "
T 5 2 0 2250 Send Payments to" + "\r\n" + "
T 5 1 0 2300 PestNow" + "\r\n" + "
T 5 1 0 2350 PO Box 2210 Ashburn, VA 20146" + "\r\n" + "
LEFT" +"\r\n" + "
ML 27\r\n" + "
TEXT 5 0 0 700\r\n"
 @sub.each do |x|
     data << x.Order.Schedule.StartTime.strftime("%m/%d/%y") + " " + x.Order.Servicecode.Description + " $" + x.Charge.to_s + " pd$" + x.Deposit.to_s + "\r\n"
#       <tr> <td> <%= x.Order.Schedule.StartTime.strftime("%m/%d/%y") %>   </td>
   #    <td> <%#= x.Order.OrderId %>   </td>
#       <td> <%= x.Order.Servicecode.Description %>   </td>
 #      <td> <%#= number_to_currency(x.Charge)%>   pd<%= number_to_currency(x.Deposit)%> </td></tr>

 end

data <<  "ENDML\r\n" 

#   data << "FORM\r\n"
data <<   "PRINT\r\n"



send_data( data, :filename => @id+".LBL" )
   end


    def workvoicemobile
@id = params[:id]
    @order = Order.find(params[:id])
  ##  @amount = @balance
    #@amount = 10.00

@oid = Order.find(params[:id])
@inv = Order.includes(:Schedule, :Servicecode,  :Property, :Customer, :Customerledgerorders).find(@oid)

@noteby = @inv.Userledgers.where("Note = 'Serv'")
@presum = Order.find(:all,
  :conditions => ["OrderCopiedFrom = ?", @oid])
@balance = @inv.Customerledgerorders.sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
@taxsum = @inv.Customerledgerorders.sum("TaxCharge")
@sub = @inv.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
# @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @balance, :relay_url => 'http://216.177.62.21:443/payments/receipt')

    respond_to do |format|
      format.html # index.html.erb
    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/workorder.pdf', :document_content => render_to_string, :document_type => "pdf", :render => 'inline', :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'workorder.pdf'
    end

    end
  end

   def cc
@gg = params[:gg]|| 11
@em = params[:em]|| 11
#@t2 = params[:t2]|| 22

      @order = Order.find(params[:id])
   @con = @order.Property

      @con.update_attributes(:GoGreen => @gg)

     @email = @order.Property.Customer
      @email.update_attributes(:Email => @em)

#    respond_to do |format|
respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @homepages }
       format.js
        format.json
    end
      #if @orderpad.update_attributes(params[:x1])
        #format.html { redirect_to(@orderpad, :notice => 'Orderpad was successfully updated.') }
        #format.html :notice => 'Orderpad was successfully updated.'
       # format.xml  { head :ok }
       # format.js

     # else
    #    format.html #{ render :action => "edit" }
     #   format.xml  { render :xml => @orderpad.errors, :status => :unprocessable_entity }
    #   format.js

#      end
 #   end

    end


   def show
     @oid = Order.find(params[:id])
        end

#    def card
#       @order = params[:Id]
#       @prop = params[:prop]
#@aut = params[:aut]
#@Settleid = params[:Settleid]
#@Agentid = params[:Agentid]
#@Custid = params[:Custid]
# @cust = Customer.find(@Custid)
#
#amount_to_charge = 1 #ten US dollars
##amount_to_charge = params[:amount].to_i
##ActiveMerchant::Billing::Base.mode = :test
#ActiveMerchant::Billing::Base.mode = :production
##ActiveMerchant::Billing::CreditCard.require_verification_value = :false
#
#creditcard = ActiveMerchant::Billing::CreditCard.new(
##:number => '4743021568285472', #Authorize.net test card, error-producing
#:number => params[:cardnumb], #Authorize.net test card, error-producing
#:verification_value => '528',
##:verification_value => '567',
##:month => 8, #for test cards, use any date in the future
#:month => params[:month],
#:year => params[:year],
##:year => 2018,
#:first_name => params[:Fn],
#:last_name => params[:Ln],
#:type => params[:ctype]
#
#)
#
#if creditcard.valid?
#gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
##ActiveMerchant::Billing::Base.gateway(:authorized_net).new(
# :login =>'pest66', # API Login ID
#:password =>'66xqt7v6dS638FYX') #Transaction Key
##:login =>'9dhEyE46F', # API Login ID
##:password =>'4r5dM89Y3HJr4R4s') #Transaction Key
#
#response = gateway.authorize(amount_to_charge*100 , creditcard
##:billing_address =>{ :name => params[:Ln] , :address1 => params[:Street]|| 'no street',
##  :city => params[:City],:state => params[:State],
##:country => 'US',:zip => params[:Zip],:phone => params[:Phone]})
#
#)
#if response.success?
##  @custledger = Customerledger.new()
##  @custledger.update_attributes(:InsertTime => Time.now, :PaymentType => 'CreditCard', :CCType => @cardtype, :CCNumber => @number, :Deposit => amount_to_charge, :Active => 1, :PropertyId => @orderid, :UpdateUserId => 1, :EntryDate => Time.now, :UpdateTime => Time.now, :UpdateReason => "CC Entry From Road App", :CCAuthNumber => response.authorization)
# @custledger = Customerledger.new()
#    @custledger.update_attributes(:CustomerId => @Custid||0 , :AgentId => @Agentid||0 , :SettlementCompanyId => @Settleid||0 ,:InsertTime => Time.now, :PaymentType => 'CreditCard', :CCType => params[:ctype], :CCNumber => params[:cardnumb], :CCExpirationDate => params[:month]+'/'+params[:year], :Deposit => amount_to_charge, :Active => 1, :PropertyId => @prop, :UpdateUserId => 1, :EntryDate => Time.now, :UpdateTime => Time.now, :Note => "CC Entry From Road App", :UpdateReason => "CC Entry From Road App", :CCAuthNumber => response.authorization)
#    @custledgerorder = Customerledgerorder.new(:LedgerId => @custledger.LedgerId)
#    @custledgerorder.update_attributes(:OrderId => @order, :Deposit => amount_to_charge, :InsertTime => Time.now,  :InsertUserId => 1, :UpdateTime => Time.now, :UpdateUserId => 1, :UpdateReason => "CC Entry From Road App")
#
# #@iscon = @con.find(@order.ContractId)
# if @aut == '1'  then
# @cust.update_attributes(:AutoPay => params[:aut], :UpdateReason => "auto pay", :CCType => params[:ctype], :CCNumber => params[:cardnumb], :CCExpirationDate => params[:month]+'/'+params[:year])
# else
#   flash[:notice] = "S"
# end
#gateway.capture(amount_to_charge, response.authorization)
# redirect_to :action => "workvoice", :id => @order
##render :text => 'Success:' + response.message.to_s and return
#flash[:message] ="Success! " + response.message.to_s and return
#
#else
#  redirect_to :action => "workvoice", :id => @order
##render :text => 'Fail:' + response.message.to_s and return
## redirect_to :action => "workvoice", :id => @order
#
#flash[:message] ="fail!" + response.message.to_s and return
#  # redirect_to :action => 'result'
#end
#else
#   redirect_to :action => "workvoice", :id => @order
#
#  flash[:message] ="Credit card not valid!" + creditcard.validate.to_s
##render :text =>'Credit card not valid: ' + creditcard.validate.to_s
##end return
#end

#  end

end

