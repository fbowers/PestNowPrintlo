class OrderpadsController < ApplicationController
  # GET /orderpads
  # GET /orderpads.xml
  
 # respond_to :html, :js
 # layout 'orderpads'
   layout "orderpads", :except => :map
 # before_filter :require_user
   #   layout 'orders'
   #   before_filter :find_cart, :except => :empty_cart
 

  def index
   # @chemicals = Chemical.all
    @orderpads = Order.limit(10).includes(:Schedule).where("Schedules.StartTime =  3/22/2011")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orderpads }
    end
  end

  # GET /orderpads/1
  # GET /orderpads/1.xml
  def show
    @orderpad = Order.includes([:Schedule, :Contracts => :ContractType]).find(params[:id])

  #  @Frank = Route.find(:all,
  #:include => [{:Schedules => {:Orders => [:Servicecode,{:Property => :Warranties}]}}],
   

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orderpad }
    end
  end

  # GET /orderpads/new
  # GET /orderpads/new.xml
  

  # GET /orderpads/1/edit
  def check
    @orderpad = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orderpad }
    end
  end


  def service
 #@orderpad = Order.find(params[:id])
 @orderpad = Order.find(1301703)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orderpad }
    end

  end

 
  def edit
# @quantity = params[:Quantity]
#@cart = current_cart
@orderpad = Order.find(params[:id])
#@orderpad = Order.includes(:Servicecode, :Orderstatus, :Schedule => :Scheduleroutes, :Property => [:Address, :Customer]).find(params[:id])
#@orderchemical = @orderpad.Orderchemicals
#@oc = Orderchemical.all
@chemicals = Chemical.where(:WorkOrderId => @orderpad.Servicecode.WorkOrderFormId, :Active => true)
@notes = Checkcomment.where(:WorkOrderId => @orderpad.Servicecode.WorkOrderFormId)
@pests = Pest.where(:WorkOrderId => @orderpad.Servicecode.WorkOrderFormId)
@temp = Temperature.find(:all)
@equip = Equipment.find(:all)

@balance = @orderpad.Customerledgerorders.sum("Charge")+@orderpad.Customerledgerorders.sum("TaxCharge")- @orderpad.Customerledgerorders.sum("Deposit")





end
 def checkpayment
   @orderpad = Order.find(params[:id])
   @Custid = params[:Custid]
   @price = @orderpad.Price
   @paymenttype = params[:paymenttype] || 'check'
   @amount = params[:amount] || '0'
   @check  = params[:check] || '1'
   @now = Time.now ||1/1/1900
@user = current_user.UserId
   @custledger =  Customerledger.create(:CustomerId => @Custid||0 , :AgentId => @Agentid||0 , :SettlementCompanyId => @Settleid||0 , :InsertUserId => @user, :CheckNumber =>@check, :InsertTime => Time.now, :PaymentType => @paymenttype, :Deposit => @amount, :Active => 1, :PropertyId => @orderpad.PropertyId, :UpdateUserId => @user, :EntryDate => Time.now, :UpdateTime => Time.now, :Note => "Payment From Road App", :UpdateReason => "Payment From Road App")
    #@custledger.update_attributes(:CustomerId => @Custid||0 , :AgentId => @Agentid||0 , :SettlementCompanyId => @Settleid||0 , :InsertUserId => @user, :CheckNumber =>@check, :InsertTime => @now, :PaymentType => @paymenttype, :Deposit => @amount, :Active => 1, :PropertyId => @prop, :UpdateUserId => @user, :EntryDate => @now, :UpdateTime => @now, :Note => "Payment From Road App", :UpdateReason => "Payment From Road App")
    @custledgerorder = Customerledgerorder.create(:LedgerId => @custledger.LedgerId, :OrderId => @orderpad.OrderId, :TaxCharge => 0, :TaxRate => 0, :Charge => 0, :Deposit => @amount, :InsertTime => @now,  :InsertUserId => @user, :UpdateTime => @now, :UpdateUserId => @user, :UpdateReason => "Payment From Road App")
#    @custledgerorder.update_attributes(:OrderId => @orderpad.OrderId, :Deposit => @amount, :InsertTime => Time.now,  :InsertUserId => @user, :UpdateTime => Time.now, :UpdateUserId => @user, :UpdateReason => "Payment From Road App")
flash[:notice] ="You just entered a payment of "+@amount
      respond_to do |format|
    #    format.html { redirect_to(@orderpad, :notice => 'Orderpad was successfully created.') }
    flash[:notice] ="You just entered a payment of "+@amount
    #  format.html { redirect_to(posts_url) }
      format.js   { render :nothing => true }
    end


 end
def test
  @followers = ["fbowers@pestnow.com" "frank.bowers@gmail.com" "fbowers@pestnow.com" "info@pestnow.com"]
  #@project.owner.followers.all
@followers.each do |f|
    UserMailer.new_project(@project, f).deliver
end

end
 
 def apcard
 #      @order = params[:Id]
      
#@aut = params[:aut]
#@Settleid = params[:Settleid]
#@Agentid = params[:Agentid]
@user = current_user.UserId
@orderpad = Order.find(params[:id])
@oid = @orderpad.OrderId
 @prop = @orderpad.PropertyId
@amount = params[:amount]
@type = params[:cardtype]
@month = params[:expmonth].to_s
@year = params[:expyear].to_s
@number = params[:ccnumber]
@custid = params[:custid]
@aut = params[:aut]
#@amount = @orderpad.Price
#@type = @cust.CCType || AMEX
#@month = @cust.CCExpirationDate.strftime("%m") || AMEX
#@year = @cust.CCExpirationDate.strftime("%y") || AMEX
#@number = @cust.CCNumber || AMEX
 @cust = Customer.find(@custid)
 @name = @cust.LastName
 @phone = @cust.Phone1
 @address = @orderpad.Property.Address.Street
 @city = @orderpad.Property.Address.City
 @state = @orderpad.Property.Address.StateId
 @zip = @orderpad.Property.Address.ZipCodeId
 @firstname = @cust.FirstName
amount_to_charge = params[:amount].to_i
#amount_to_charge = 10.00 #ten US dollars
#amount_to_charge = @amount
ActiveMerchant::Billing::Base.mode = :production
#ActiveMerchant::Billing::CreditCard.require_verification_value = :false

creditcard = ActiveMerchant::Billing::CreditCard.new(
:number => @number,
#:number => '4743021568285472', #Authorize.net test card, error-producing
#:number => params[:cardnumb], #Authorize.net test card, error-producing
:verification_value => '123',
#:verification_value => '567',
#:month => @month, #for test cards, use any date in the future
:month => @month,
:year => @year,
#:year => @year,
:first_name => @firstname,
:last_name => @name,
#:type => @type
:type => @type
)
if creditcard.valid?

gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
#ActiveMerchant::Billing::Base.gateway(:authorized_net).new(
         :login =>'pest66', # API Login ID
:password =>'66xqt7v6dS638FYX') #Transaction Key
#:login =>'9dhEyE46F', # API Login ID
#:password =>'4r5dM89Y3HJr4R4s') #Transaction Key

response = gateway.authorize(amount_to_charge *100, creditcard)

if response.success?
#  @custledger = Customerledger.new()
#  @custledger.update_attributes(:InsertTime => Time.now, :PaymentType => 'CreditCard', :CCType => @cardtype, :CCNumber => @number, :Deposit => amount_to_charge, :Active => 1, :PropertyId => @orderid, :UpdateUserId => 1, :EntryDate => Time.now, :UpdateTime => Time.now, :UpdateReason => "CC Entry From Road App", :CCAuthNumber => response.authorization)
 @custledger = Customerledger.create(:CustomerId => @custid||0 , :AgentId => @Agentid||0 , :SettlementCompanyId => @Settleid||0 ,:InsertTime => Time.now, :PaymentType => 'CreditCard', :CCType => @type, :CCNumber => @number, :CCExpirationDate => @month+'/'+@year, :Deposit => @amount, :Active => 1, :PropertyId => @prop, :InsertUserId => @user, :UpdateUserId => @user, :EntryDate => Time.now, :UpdateTime => Time.now, :Note => "Autopay/CC From Road App", :UpdateReason => "Autopay/CC From Road App", :CCAuthNumber => response.authorization)
 @custledgerorder = Customerledgerorder.create(:LedgerId => @custledger.LedgerId, :OrderId => @oid, :Charge => 0, :TaxCharge => 0, :TaxRate => 0, :Deposit => amount_to_charge, :InsertTime => Time.now,  :InsertUserId => @user, :UpdateTime => Time.now, :UpdateUserId => @user, :UpdateReason => "Autopay From Road App")
gateway.capture(amount_to_charge *100, response.authorization)
@exp = @month+'/'+@year
@reason = 'autopay selected'
if @aut == '1'  then
 @cust.update_attributes(:AutoPay => params[:aut], :UpdateReason => @reason, :CCType => @type, :CCNumber => @number, :CCExpirationDate => @exp)
 else
   #@month+'/'+@year
   flash[:notice] = "S"
 end
flash[:notice] ="Success! " + response.message.to_s and return
format.js
else
#render :text => 'Fail:' + response.message.to_s and return
# redirect_to :action => "workvoice", :id => @order

flash[:notice] ="fail!" + response.message.to_s and return

  # redirect_to :action => 'result'
end
else
 #  redirect_to :action => "edit", :id => @order
 #redirect_to [:edit, @orderpad]
 #redirect_to :back

  flash[:notice] ="Credit card not valid! Try again." + creditcard.validate.to_s
 
#render :text =>'Credit card not valid: ' + creditcard.validate.to_s
#end return
end

  end


  # POST /orderpads
  # POST /orderpads.xml
  def create
    @orderpad = Order.new(params[:orderpad])

    respond_to do |format|
      if @orderpad.save
        format.html { redirect_to(@orderpad, :notice => 'Orderpad was successfully created.') }
        format.xml  { render :xml => @orderpad, :status => :created, :location => @orderpad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orderpad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orderpads/1
  # PUT /orderpads/1.xml
  def update
      
    @orderpad = Order.find(params[:id])

     # @quan = params[:item_quantity]||=  10
   # @quan = 66
   # @use = Userroute.includes(:User => :Usercommissionrate).where(:RouteId => @rou, :Active => 1, :EndTime => @time_range )
       # @oc = Orderchemical.where(:OrderId =>  1361750)
        #@oc.each do |c|

     #new(:OrderId => @order.OrderId, :ChemicalId => @chemy.ChemicalId)
        #@oc.update_all(:Quantity => 16)
  #end
    respond_to do |format|
      if @orderpad.update_attributes(params[:orderpad])
        format.html { redirect_to(@orderpad, :notice => 'Orderpad was successfully updated.') }
       # format.html :notice => 'Orderpad was successfully updated.'
        format.xml  { head :ok }
        format.js

      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orderpad.errors, :status => :unprocessable_entity }
        #format.js

      end
    end
  end

    def add_arrive
@t1 = params[:t1]|| 11
@t2 = params[:t2]|| 22

      @orderpad = Order.find(params[:id])
   
      @orderpad.update_attributes(:CheckLongitude => @t2, :CheckLatitude => @t1, :TimeIn => Time.now )
      respond_to do |format|
      if @orderpad.update_attributes(params[:x1])
        #format.html { redirect_to(@orderpad, :notice => 'Orderpad was successfully updated.') }
        #format.html :notice => 'Orderpad was successfully updated.'
        format.xml  { head :ok }
        format.js

      else
        format.html #{ render :action => "edit" }
        format.xml  { render :xml => @orderpad.errors, :status => :unprocessable_entity }
       format.js

      end
    end

    end

 
def addchem
   @oid = params[:oid]||= "450"
 @chem = params[:chem]||= "4"
   @quan = params[:quan]||= "100"
#@cart = current_cart
 chem = Chemical.find(params[:id])
#@orderchemical = @cart.add_product(chem.id)
# @orderchemical = @cart.orderchemicals.build(:ChemId => chem.id, :Quantity => @quan)
@och = Orderchemical.new(:ChemId => chem.id)
@och.update_attributes(:OrderId => @oid, :Quantity => @quan)
end
# @orderpad = Order.find(params[:id])
#@quan = params[:quan]||= "100"
 #@chid = params[:chid]||= "2"
 #@chid = params[:chid]||= [5,6]
#@chid = params[:chid]
#@cart = current_cart
# chem = Chemical.find(@chid)

# params[:chid].each do |uh|
#@orderchemical = @cart.add_product(chem.id)
#@orderchemical = @cart.add_product(uh)
#@orderchemical = @cart.orderchemicals.build(uh)
#chemical = @cart.orderchemicals.new(uh)
#if chemical.save
#  @chid << chemical
#else
#  @chid << chemical

 #current_item = orderchemicals.build(:ChemId => chemical)
#current_item.Quantity += 0
#orderchemicals << current_item
#params[:users].each do |user_hash|
 #   user = User.new(user_hash)
 #   if user.save
 #     @users << user
 #   else
 #     @failed << user
 #   end
 # end
 
#  @quan = params[:item_quantity]||= "100"

#@cart = current_cart
# chem = Chemical.find(params[:id])
# @orderchemical = @cart.orderchemicals.build(:ChemId => chem.id, :Quantity => @quan)

respond_to do |format|
  format.js
end


def add_to_cart
  @quan = params[:item_quantity]||= "100"

@cart = current_cart
 chem = Chemical.find(params[:id])
#@orderchemical = @cart.add_product(chem.id)
 @orderchemical = @cart.orderchemicals.build(:ChemId => chem.id, :Quantity => @quan)

end
respond_to do |format|
format.js
end

  def add_to_cartworking
# @quan = 55
@quan = params[:item_quantity]||= "1"
@cart = current_cart
#@quan = params[:item_quantity]#.nil? ? 1 :  params[:item_quantity]
 chem = Chemical.find(params[:id])
@orderchemical = @cart.add_product(chem.id, @quan)
#  @orderchemical = @cart.orderchemicals.build(:Chemical_id => chem.id)
end
respond_to do |format|
format.js
end
  


  def sub_to_cart
    begin
      chemical = Chemical.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product")
    else
      @current_item = @cart.sub_product(chemical)
      redirect_to_index unless request.xhr?
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index unless request.xhr?
  end

  def map

      @start = params[:startdate]||=  Time.now.strftime("%m/%d/%Y")
#@start = Time.now.strftime("%m/%d/%Y")
@end = @start + " 11:59:00PM"
@user = current_user.UserId
@cur = Route.joins(:Userroutes).where([" Userroutes.UserId = ? AND UserRoutes.Active = 1 AND UserRoutes.EndTime > ?", @user, Time.now] )
@hope = Route.find(@cur)
#sched = Order.includes(:Servicecode, :Orderstatus, :Schedule => :Scheduleroutes, :Property => :Address).where(["Orders.OrderStatusId != 4 AND Scheduleroutes.RouteId = ? AND Schedules.StartTime BETWEEN ? AND ?" , @hope, @start, @end])
@sched = Order.includes(:Servicecode, :Orderstatus, :Schedule => :Scheduleroutes, :Property => :Address).where(["Orders.OrderStatusId != 4 AND Scheduleroutes.RouteId = ? AND Schedules.StartTime BETWEEN ? AND ?" , @hope, @start, @end])

@count = @sched.count()
@sum = @sched.sum("Price")
    points = Address.select("AddressId, Latitude, Longitude").includes(:Properties => :Orders).where(["Orders.OrderId IN (?)",@sched]).map {|x| {:id=>x.AddressId, :latitude=>x.Latitude, :longitude=>x.Longitude}}

    addresses = points.to_json
		
    @coords = addresses.html_safe
	


	end

  #START:checkout
 # def checkout
 #   if @cart.items.empty?
 #     redirect_to_index("Your cart is empty")
 #   else
     # @order = Orderchemical.new
 #    format.html { redirect_to(:back, :notice => 'Order was successfully updated.') }
 #    redirect_to_index("cart is not empty")
 #   end
 # end
  #END:checkout

  #START:save_order
#  def save_order
# @cart.items.each do |item|
#   @o = Orderchemical.new(@cart)
#   @o.update_attributes(:OrderId => @order.OrderId, :ChemicalId => item.chid,:Qty=> item.quantity)
#     end
#     if @o.save
#      session[:cart] = nil
#      redirect_to_index("Thank you for your order")
#    else
#      redirect_to_index("Problem")
     # render :action => :checkout
 # end
 # end

  #END:save_order

  private

   def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :back
  end

  #START:find_cart

  
   
  
  #END:find_cart<
  end

  # DELETE /orderpads/1
  # DELETE /orderpads/1.xml
 

