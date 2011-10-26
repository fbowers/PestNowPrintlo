class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml

  respond_to :html, :xml, :json
#layout 'orderpads'
  layout 'orders'
 # before_filter :require_user

  #before_filter :find_cart, :except => :empty_cart

  def index


#@order = Order.all(:limit => 1000)

 t = Time.now 
 @route = params[:route]
#@route = params[:route]||
#@form = params[:form]||= ["71" "85" "73" "77"]
#@form = params[:form]||= "85"
@branch = params[:branch]||= "1"
@start = params[:startdate]||=  t.strftime("%m/%d/%Y")
@route = params[:route]|| []
@end = params[:startdate]+ " 11:59:00PM"

#@g = @end.to_time
#@dayroute =  @g


@orders_today =[]
Route.find(:all,
#:include => [{:Schedules => {:Scheduleroutes => :Orders }}],
:include => [:Scheduleroutes => {:Schedule => :Order} ],
:conditions => if params[:route].blank? then ["Schedules.StartTime BETWEEN ? AND ? AND Routes.Active = 1 AND Orders.OrderStatusID IN (8, 3, 2, 5) AND Routes.Branchid = ? ", @start, @end,  @branch ]
else
["Schedules.StartTime BETWEEN ? AND ? AND Routes.Active = 1 AND Orders.OrderStatusID IN (8, 3, 2, 5) AND Routes.Branchid = ? AND Routes.RouteId IN (?)", @start, @end,  @branch, @route]
end,
:order => "RouteName").each do |route|

   @orders_today << {:Route => route,
                    :user => route.Users.find(:all,
                    :conditions => ["UserRoutes.EndTime  > ? AND UserRoutes.Active = 1 ", @dayroute]),
                    :schedules => route.Schedules.find(:all,
                    :order => "Schedules.StartTime ASC",
                    :conditions => ["Schedules.StartTime BETWEEN ? AND ?", @start, @end ]),
                    :sched => route.Schedules.includes({:Orders => :Servicecode}).where("Schedules.StartTime BETWEEN ? AND ? AND Servicecodes.WorkOrderFormId = ? ", @start, @end, @form),
#:sum => route.Schedules.includes(:Orders).where("Schedules.StartTime BETWEEN ? AND ?  ", @start, @end).sum(:Price),
#:greencount => route.Schedules.includes({:Orders => :Servicecode}).where("Schedules.StartTime BETWEEN ? AND ? AND Servicecodes.WorkOrderFormId = 71 ", @start, @end).count(:OrderId),
#:redcount => route.Schedules.includes({:Orders => :Servicecode}).where("Schedules.StartTime BETWEEN ? AND ? AND Servicecodes.WorkOrderFormId = 85 ", @start, @end).count(:OrderId),
#:bluecount => route.Schedules.includes({:Orders => :Servicecode}).where("Schedules.StartTime BETWEEN ? AND ? AND Servicecodes.WorkOrderFormId = 73 ", @start, @end).count(:OrderId),
#:purplecount => route.Schedules.includes({:Orders => :Servicecode}).where("Schedules.StartTime BETWEEN ? AND ? AND Servicecodes.WorkOrderFormId = 77 ", @start, @end).count(:OrderId),
#:contractcount => route.Schedules.includes({:Orders => :Contract}).where(" Contracts.OriginatingOrderId = Orders.OrderId AND Schedules.StartTime BETWEEN ? AND ?", @start, @end).count({:Orders => :Contracts}["OriginatingOrderId"]),
              
   }
    end
 @daytotal =  Order.includes([:Schedule, :Servicecode]).where("Schedules.StartTime BETWEEN ? AND ? AND Branchid = ? ", @start, @end, @branch).sum(:Price)
 @greentotal =  Order.includes([:Schedule, :Servicecode]).where("Schedules.StartTime BETWEEN ? AND ? AND Branchid = ? AND Servicecodes.WorkOrderFormId = ? ", @start, @end, @branch, "71").count(:OrderId)
 @bluetotal =  Order.includes([:Schedule, :Servicecode]).where("Schedules.StartTime BETWEEN ? AND ? AND Branchid = ? AND Servicecodes.WorkOrderFormId = ? ", @start, @end, @branch, "73").count(:OrderId)
 @redtotal =  Order.includes([:Schedule, :Servicecode]).where("Schedules.StartTime BETWEEN ? AND ? AND Branchid = ? AND Servicecodes.WorkOrderFormId = ? ", @start, @end, @branch, "85").count(:OrderId)
 @purpletotal =  Order.includes([:Schedule, :Servicecode]).where("Schedules.StartTime BETWEEN ? AND ? AND Branchid = ? AND Servicecodes.WorkOrderFormId = ? ", @start, @end, @branch, "77").count(:OrderId)
 @counttotal =  Order.includes(:Schedule).where("Schedules.StartTime BETWEEN ? AND ? AND Branchid = ? ", @start, @end, @branch).count(:OrderId)
 #@contracttotal = Contract.includes({:Order => :Schedule }).where("Schedules.StartTime BETWEEN ? AND ? AND Orders.Branchid = ? ", @start, @end,  @branch).count(:ContractId)


    respond_to do |format|
      format.html # index.html.erb
       
    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/index.pdf', :document_content => render_to_string, :document_type => "pdf", :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'Coversheet.pdf'
    end

    end
  end

  def fworkorder
t = Time.now
@orders = Order.all(:limit => 1000)
@branch = params[:branch]||= "7"
@start = params[:startdate]||=  t.strftime("%m/%d/%Y")
@route = params[:route]|| []
@end = params[:startdate]+ " 11:59:00PM"
@form = params[:form]||= "71"


#@ractive = Route.all(
#:conditions => ["Active = 1 AND BranchId = ?", @branch],
#:order => "RouteName ASC")
#@bactive = Branch.all(
#:conditions => "BranchId In (1,3,5,6,7,9)",
#:order => "BranchId")
#@route_sum =[]

@Frank = Route.find(:all,
  #[:Scheduleroutes => {:Schedule => :Order} ]
  :include => [{:Scheduleroutes =>{:Schedule => {:Order => [:Servicecode,{:Property => :Warranties}]}}}],
    :conditions => if params[:route].blank? then ["Schedules.StartTime BETWEEN ? AND ? AND Routes.Active = 1 AND Routes.Branchid = ? AND Servicecodes.WorkOrderFormId = ? ", @start, @end,  @branch, @form ]
else
["Schedules.StartTime BETWEEN ? AND ? AND Routes.Active = 1 AND Routes.Branchid = ?  AND Routes.RouteId IN (?)AND Servicecodes.WorkOrderFormId = ? ", @start, @end,  @branch, @route, @form]
end,
      :limit => 1000)

   
#@ocount = @Frank.count

#@History = History.limit(10).joins(:Schedule).order("Schedule.StartTime DESC")
#.where("PropertyId  IN (?)",  @Frank)

# UserMailer.welcome_email(@user).deliver

    respond_to do |format|
      format.html # index.html.erb

    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/workorder.pdf', :document_content => render_to_string, :document_type => "pdf", :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'workorder.pdf'
    end



    end
  end

  def invoice

@oid = 1296027

#@cid = @inv.OrderCopiedFrom

@inv = Order.includes(:Servicecode, :Schedule, :Property, :Customer, :Customerledgerorders).find(@oid)
  
@presum = Order.find(:all,
  #:include => :Customerledgerorders,
  :conditions => ["OrderCopiedFrom = ?", @oid])
  #find(@oid)
  #where("Order.OrderCopiedFrom = ?" , @oid)
    #:all,
  #:include => [{:Order => [:Servicecode, :Schedule, :Property ]}],
    #:conditions => ["Order.OrderId = ?", @oid])
@balance = @inv.Customerledgerorders.sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
@taxsum = @inv.Customerledgerorders.sum("TaxCharge")
@sub = @inv.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)



    respond_to do |format|
      format.html # index.html.erb

    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/workorder.pdf', :document_content => render_to_string, :document_type => "pdf", :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'workorder.pdf'
    end

    end
  end
 def contract
     t = Time.now
@branch = params[:branch]||= "1"
@start = params[:startdate]||=  t.strftime("%m/%d/%Y")
@route = params[:route]|| []
@end = params[:startdate]+ " 11:59:00PM"


   @kim = Contract.find(:all,
  :include => [{:Order => {:Schedule => :Routes }}],
    :conditions => if params[:route].blank? then ["Schedules.StartTime BETWEEN ? AND ? AND Orders.Branchid = ? ", @start, @end,  @branch, ]
else
["Schedules.StartTime BETWEEN ? AND ? AND Orders.Branchid = ?  AND Routes.RouteId IN (?)", @start, @end,  @branch, @route]
end,
      :limit => 100)

   

   respond_to do |format|
      format.html # index.html.erb

    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/contract.pdf', :document_content => render_to_string, :document_type => "pdf", :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'contract.pdf'
    end
    end
  end

  # GET /orders/1
  # GET /orders/1.xml

 def wdireport

@wdiid =226599
   @wdi = WDI.includes([:User],[{:Order => [:Schedule, :Property] }]).find(@wdiid)

@oid = @wdi.OriginatingOrderId

#@inv2 = Order.where.1294310)
@inv = Order.includes(:Servicecode, :Schedule, :Property, :Customer, :Customerledgerorders).find(1294310)
#@inv = Order.includes(:Servicecode, :Schedule, :Property, :Customer, :Customerledgerorders).where("OrderId =?", params[@oid])

@presum = Order.where("OrderCopiedFrom =?", @oid)

  #:include => :Customerledgerorders,
 # :conditions => ["OrderCopiedFrom = ?", @oid])
  #find(@oid)
  #where("Order.OrderCopiedFrom = ?" , @oid)
    #:all,
  #:include => [{:Order => [:Servicecode, :Schedule, :Property ]}],
    #:conditions => ["Order.OrderId = ?", @oid])
#@balance = @inv.Customerledgerorders.sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
@balance = Customerledgerorder.where("OrderId in (?)", @presum).sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
#@taxsum = @inv.Customerledgerorders.sum("TaxCharge")
@taxsum =Customerledgerorder.where("OrderId in (?)", @presum).sum("TaxCharge")
#@sub = @presum.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
#@sub = @inv.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
@sub = Customerledgerorder.limit(10).includes(:Order => [:Servicecode, :Schedule]).where("OrderId in (?)", @presum)



   respond_to do |format|
      format.html # index.html.erb

    format.pdf do
      data = DocRaptor.create(:test => true, :name => 'orders/wdireport.pdf', :document_content => render_to_string, :document_type => "pdf", :prince_options => {:baseurl => 'http://nofail.de'})
      send_data data, :type => 'application/pdf', :filename => 'wdireport.pdf'
    end
    end
  end

  # GET /orders/1
  # GET /orders/1.xml

  def show
   # @order = Order.find(params[:id])
@Frank = Order.find(params[:id])
#@Prop = @Frank.Property
#@Frank = Order.includes(:Schedule => :Routes,:Property => {:Contracts => :Contracttype}).find(params[:id])
#@Frank = Order.includes([:Schedule => :Routes]).find(params[:id])
@time_range = (Time.now.midnight-1.day)..( Time.now.midnight + 50.years)
 @user = current_user.UserId
@taxrate = @Frank.Property.Address.Taxrate.TaxRate if not nil
@tax = @taxrate *@Frank.Price
@war = @Frank.Property.Warranties.includes(:Property => :Warranties)
@con = @Frank.Property.Contracts.includes(:Contracttype)
@his = @Frank.Property.Histories.limit(20).includes({:Schedule => :Routes}, :Servicecode).order("Schedules.StartTime DESC").where('Schedules.StartTime is not null ' )
#@use = Userroute.includes(:User => :Usercommissionrate).where(:RouteId => @rou, :Active => 1, :EndTime => @time_range )
@sched = @Frank.Schedule
#@t=@frank.UserRoute
@rou = Route.joins(:Userroutes).where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime => @time_range})
@ur = Userroute.where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime => @time_range})
@ul = @Frank.Userledgers.where(:OrderId => @Frank)
@cl = @Frank.Customerledgerorders.where(:OrderId => @Frank)
#  @soldby = @Frank.SoldBy || nil
#@users = User.where()
#@comrate=@Frank.Usercommissionrate.Rate.Where("")
    @count = @rou.count

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  
  

  def edit
    @order = Order.find(params[:id])

     t = Time.now
#t = 3/1/2011
@start = params[:startdate]||=  t.strftime("%m/%d/%Y")
#@start = params[:startdate]||=  "3/4/2011"
@end = params[:startdate]+ " 11:59:00PM"
#@user = current_user.UserId
@user = 374
@time_range = (Time.now.midnight-17.day)..( Time.now.midnight + 50.years)

  @rou = Route.joins(:Userroutes).where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime => @time_range})
#@hope = Route.joins(:Userroutes, :Schedules).where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime => @time_range})
@use = Userroute.where(:RouteId => @rou, :Active => 1, :EndTime => @time_range )
@count = @use.count
@useall = [374,390]
@rate = Usercommissionrate.where(:ServiceCodeId => 10, :UserId => @useall)
@total = @rate * @count
  end
  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
        format.js

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml

  def makepayment

  end
  
  def update


    @checkstatus = params[:checkstatus]
    @tin = params[:tin] || Time.now
    @order = Order.find(params[:id])
    
    @order.update_attributes(:UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :TimeIn => @tin, :TimeOut => Time.now, :CheckInResultId => @checkstatus  )
    
#case @checkstatus
 #     when "1" then @order.update_attributes(:OrderStatusId => 8)
  #  when "1",  [@order.Price > 0]then @order.update_attributes(:OrderStatusId => 3)
   #  when "1", [@order.Price == 0] then @order.update_attributes(:OrderStatusId => 8)
  #  when "2" then @order.update_attributes(:OrderStatusId => 4)
   # when "3" then @order.update_attributes(:OrderStatusId => 3)
   # when "4" then @order.update_attributes(:OrderStatusId => 3)
   # when "5" then @order.update_attributes(:OrderStatusId => 8)
   #  end


  

t = Time.now
 #   t = 3/3/2011
@start = params[:startdate]||=  t.strftime("%m/%d/%Y")
#@start = params[:startdate]||=  "3/22/2011"
@end = params[:startdate]+ " 11:59:00PM"
@user = current_user.UserId
#@user = 382
@time_range = (Time.now.midnight-1.day)..( Time.now.midnight + 50.years)
@rou = Route.joins(:Userroutes).where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime => @time_range})
@use = Userroute.includes(:User => :Usercommissionrate).where(:RouteId => @rou, :Active => 1, :EndTime => @time_range )
#@taxrate = @order.Property.Addresses.Taxrate.TaxRate
@taxrate = @order.Property.Address.Taxrate.TaxRate
@tax = @taxrate * @order.Price
#@tax = @taxrate * @order.Price
@count = @use.count
@price = @order.Price
@id = @order.OrderId
@now = Time.now
  if @checkstatus == "1" or  @checkstatus == "5"

    @use.each do |x|
#     @useledger = Userledger.new(params[x])
    #Car.new(:name => params[:car])
    @useledger = Userledger.create(:UserId => x.UserId, :EntryDate => @now,:InsertTime => @now,:InsertUserId => current_user.UserId, :Active => 1, :Note => "Serv",
    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TotalAmount => @price, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
    :Charge => x.User.Usercommissionrate.Rate/@count*@price )
    #@useledger.update_attributes()
    end


      if @order.Customer.AutoPay == false
      @order.update_attributes(:UpdateReason => "no auto pay" )
        else
           @order.update_attributes(:UpdateReason => "Yes auto pay" )
         
      end

   #   if @con == nil
   #     flash[:notice] = "S"
   #   else
    #    @con.update_attributes(:ServiceDate => Time.now)
   #   end
if @order.SoldBy == nil
flash[:notice] = "S"
            
  else


    @soldby = @order.SoldBy || nil
    @soldbyrate = @order.Usercommissionrate.Rate || nil
    @sales = Userledger.create(:EntryDate => @now, :InsertTime => @now,:InsertUserId => current_user.UserId, :UserId => @soldby, :Active => 1, :Note => "Sales", :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Entry From Road App",
    :TotalAmount => @price, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*@price)
#    @sales.update_attributes(:OrderId => (params[:id]), :InsertTime => Time.now, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Entry From Road App",
#    :TotalAmount => @price, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*@price)
end
#@con = @order.Property.Contracts.includes(:Contracttype)
@con = @order.Property.Contracts
 
      if @order.ContractId == nil
        flash[:notice] = "no contract"
              else
        @iscon = @con.find(@order.ContractId)
        @iscon.update_attributes(:ServiceDate => Time.now)
      end


      if @order.Servicecode.CreatesContract == false# or @soldby == nil# or @order.Contract.Frequency.Days == 0
    
flash[:notice] = "S"

        else if
            @order.Servicecode.CreatesContract == true and @order.Contract.Frequency.Days == 0
#@con = @order.Property.Contracts
@con.update_attributes(:Active => 1, :Proposed => 0, :StartDate => Time.now, :ServiceDate => Time.now)
 else if
            @order.Servicecode.CreatesContract == true and @soldby == nil
#@con = @order.Property.Contracts
@con.update_attributes(:Active => 1, :Proposed => false, :StartDate => Time.now, :ServiceDate => Time.now)
  else
@recur = @order.Contract.RecurringPrice
    @con = @order.Contract
    @freq = (365/(@order.Contract.Frequency.Days)) -1
    @soldby = @order.SoldBy || nil
    @soldbyrate = @order.Usercommissionrate.Rate || nil
    @sales = Userledger.create(:EntryDate => @now,:InsertUserId => current_user.UserId, :UserId => @soldby, :Active => 1, :OrderId => (params[:id]), :InsertTime => @now, :UpdateUserId => current_user.UserId, :UpdateTime => @now,:UpdateReason => "Reccuring Entry From Road App",
    :TotalAmount => @recur*@freq, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*(@recur*@freq))
#    @sales.update_attributes(:OrderId => (params[:id]), :InsertTime => Time.now, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Reccuring Entry From Road App",
#    :TotalAmount => @recur*@freq, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*(@recur*@freq))
   @con.update_attributes(:Active => 1, :Proposed => false, :StartDate => @now, :ServiceDate => @now)

end
end
      end


      

#if  @order.Contract.Frequency.Days == 0 and @order.Servicecode.CreatesContract == true
#  @con.update_attributes(:Active => 1, :Proposed => 0, :StartDate => Time.now, :ServiceDate => Time.now)

   # else
    # flash[:notice] = "S"
#end


    @L = Customerledger.create(:EntryDate => @now, :InsertTime => @now, :Active => 1,:PropertyId => @order.PropertyId || nil, :AgentId => @order.AgentId || nil, :CustomerId => @order.CustomerId || nil,
   :SettlementCompanyId => @order.SettlementCompanyId || nil, :Charge => @price, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => @now, :TaxCharge => @tax, :TaxRate => @taxrate, :UpdateReason => "Entry From Road App", :Coupon => false, :LedgerCategoryId => 1)
#    @L.update_attributes(:UpdateReason => "Entry From Road App", :Coupon => false, :LedgerCategoryId => 1)

    @LD = @L.LedgerId

   @CL= Customerledgerorder.create(:InsertTime => @now, :LedgerId => @LD,:OrderId => @order.OrderId, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => @now, :UpdateReason => "Entry From Road App", :TaxCharge => @tax, :TaxRate => @taxrate, :Deposit => 0, :Charge => @price )
   #@CL.update_attributes(:Charge => @price)



    if  @order.Orderchecklistitems.detect{|el| el.CheckListItemId == 1}

        flash[:notice] = "Already has Check list"
       
     else

        @f = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 1,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
      # @f.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
    @f1 = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 2,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
    #   @f1.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
       @f2 = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 15,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
       #@f2.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
 end


      @n = Orderchecklistitem.where(:OrderId => @order, :CheckListItemId => [2, 15])
@n.update_all(:IsComplete => true,:UpdateUserId => current_user.UserId, :UpdateTime => Time.now)


     # @order.Orderchecklistitems(2).update_attributes(:IsComplete => true)

respond_to do |format|
      if @order.update_attributes(params[:order])
#      session[:cart] = nil
      UserMailer.workvoice_email(@order).deliver
       format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
       format.xml  { head :ok }
        format.js
       #  format.js { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }

      else
      format.html { redirect_to :back }
       # format.html { render :action => :orderpad/edit }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
           format.js

      end
    end
      if @checkstatus == "1" and @order.Price == 0
      @order.update_attributes(:OrderStatusId => 3)
    elsif
        @checkstatus == "1" and @order.Price > 0
      @order.update_attributes(:OrderStatusId => 8)
      elsif
        @checkstatus == "2"
      @order.update_attributes(:OrderStatusId => 3)
      elsif
        @checkstatus == "3"
      @order.update_attributes(:OrderStatusId => 3)
      elsif
        @checkstatus == "4"
      @order.update_attributes(:OrderStatusId => 3)
      elsif @checkstatus == "5" and @order.Price == 0
      @order.update_attributes(:OrderStatusId => 3)

    else
        @checkstatus == "5" and @order.Price > 0
      @order.update_attributes(:OrderStatusId => 8)

    end

   else

     @use.each do |x|
     @useledger = Userledger.create(:UserId => x.UserId, :EntryDate => @now,:InsertTime => @now,:InsertUserId => current_user.UserId, :Active => 1, :Note => "Serv",
    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TotalAmount => 0, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
    :Charge => x.User.Usercommissionrate.Rate/@count*@price )

#    @useledger = Userledger.new(x)
#   @useledger.update_attributes(:InsertTime => @now, :EntryDate => @now, :InsertUserId => current_user.UserId, :UserId => x.UserId, :Active => 1,
#    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => @now, :UpdateReason => "Entry From Road App", :TotalAmount => 0, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
#    :Charge => x.User.Usercommissionrate.Rate/@count*0)
    end

respond_to do |format|
      if @order.update_attributes(params[:order])
#      session[:cart] = nil
      #UserMailer.workvoice_email(@order).deliver
     #  format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
       format.xml  { head :ok }
         format.js# { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }

      else
     #   format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
      #format.html { redirect_to :back }
       # format.html { render :action => :orderpad/edit }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
           format.js

      end
    end
 
   end

  end

  def updatenowork


    @checkstatus = params[:checkstatus]
    @order  = Order.find(params[:id])
    
    @order.update_attributes(:UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :TimeOut => Time.now, :CheckInResultId => @checkstatus  )
#  @chem = params[:chid][]||[1,3]
#@qua = params[:qua][]||[10,20]
t = Time.now
 @start = Time.now.strftime("%m/%d/%Y")
@end = @start + " 11:59:00PM"
@user = current_user.UserId

#@start = params[:startdate]||=  t.strftime("%m/%d/%Y")
##@start = params[:startdate]||=  "3/22/2011"
#@end = params[:startdate]+ " 11:59:00PM"
#@user = current_user.UserId
#@user = 382
#@cur = Rubyroute.where("UserId = ?", @user)
@time_range = (Time.now.midnight-1.day)..( Time.now.midnight + 50.years)
@rou = Route.joins(:Userroutes).where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime => @time_range})
@use = Userroute.includes(:User => :Usercommissionrate).where(:RouteId => @rou, :Active => 1, :EndTime => @time_range )
#@taxrate = @order.Property.Addresses.Taxrate.TaxRate
@taxrate = @order.Property.Address.Taxrate.TaxRate
@tax = @taxrate * @order.Price
#@tax = @taxrate * @order.Price
@count = @use.count
@price = @order.Price
@id = @order.OrderId

   if @checkstatus == "1" or  @checkstatus == "5"

      
    @use.each do |x|
    @useledger = Userledger.new(x)
    @useledger.update_attributes(:EntryDate => Time.now, :InsertTime => Time.now,:InsertUserId => current_user.UserId, :UserId => x.UserId, :Active => 1, :Note => "Serv",
    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TotalAmount => @price, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
    :Charge => x.User.Usercommissionrate.Rate/@count*@price)
    end

      if @order.Customer.AutoPay == false
      @order.update_attributes(:UpdateReason => "no auto pay" )
        else
           @order.update_attributes(:UpdateReason => "Yes auto pay" )
         
      end

if @order.SoldBy == nil
flash[:notice] = "S"
            
  else


    @soldby = @order.SoldBy || nil
    @soldbyrate = @order.Usercommissionrate.Rate || nil
    @sales = Userledger.new(:EntryDate => Time.now, :InsertTime => Time.now,:InsertUserId => current_user.UserId, :UserId => @soldby, :Active => 1, :Note => "Sales", :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Entry From Road App",
    :TotalAmount => @price, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*@price)
   # @sales.update_attributes(:OrderId => (params[:id]), :InsertTime => Time.now, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Entry From Road App",
    #:TotalAmount => @price, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*@price)
end
#@con = @order.Property.Contracts.includes(:Contracttype)
@con = @order.Property.Contracts
 
      if @order.ContractId == nil
        flash[:notice] = "no contract"
              else
        @iscon = @con.find(@order.ContractId)
        @iscon.update_attributes(:ServiceDate => Time.now)
      end


      if @order.Servicecode.CreatesContract == false# or @soldby == nil# or @order.Contract.Frequency.Days == 0
    
flash[:notice] = "S"

        else if
            @order.Servicecode.CreatesContract == true and @order.Contract.Frequency.Days == 0
#@con = @order.Property.Contracts
@con.update_attributes(:Active => 1, :Proposed => 0, :StartDate => Time.now, :ServiceDate => Time.now)
 else if
            @order.Servicecode.CreatesContract == true and @soldby == nil
#@con = @order.Property.Contracts
@con.update_attributes(:Active => 1, :Proposed => false, :StartDate => Time.now, :ServiceDate => Time.now)
  else
@recur = @order.Contract.RecurringPrice
    @con = @order.Contract
    @freq = (365/(@order.Contract.Frequency.Days)) -1
    @soldby = @order.SoldBy || nil
    @soldbyrate = @order.Usercommissionrate.Rate || nil
    @sales = Userledger.new(:EntryDate => Time.now, :InsertTime => Time.now,:InsertUserId => current_user.UserId, :UserId => @soldby, :Active => 1, :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Reccuring Entry From Road App",
    :TotalAmount => @recur*@freq, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*(@recur*@freq))
   # @sales.update_attributes(:OrderId => (params[:id]), :InsertTime => Time.now, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Reccuring Entry From Road App",
   # :TotalAmount => @recur*@freq, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*(@recur*@freq))
   @con.update_attributes(:Active => 1, :Proposed => false, :StartDate => Time.now, :ServiceDate => Time.now)

end
end
      end


      

    @L = Customerledger.new(:EntryDate => Time.now, :InsertTime => Time.now, :Active => 1,:PropertyId => @order.PropertyId || nil, :AgentId => @order.AgentId || nil, :CustomerId => @order.CustomerId || nil,
   :SettlementCompanyId => @order.SettlementCompanyId || nil, :Charge => @price, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :TaxCharge => @tax, :TaxRate => @taxrate, :UpdateReason => "Entry From Road App", :Coupon => false, :LedgerCategoryId => 1)
   # @L.update_attributes(:UpdateReason => "Entry From Road App", :Coupon => false, :LedgerCategoryId => 1)

    @LD = @L.LedgerId

   @CL= Customerledgerorder.new(:InsertTime => Time.now, :LedgerId => @LD,:OrderId => @order.OrderId, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TaxCharge => @tax, :TaxRate => @taxrate, :Charge => @price )
  # @CL.update_attributes(:Charge => @price)



    if  @order.Orderchecklistitems.detect{|el| el.CheckListItemId == 1}

        flash[:notice] = "Already has Check list"
       
     else

        @f = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 1,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
     #  @f.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
    @f1 = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 2,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
    #   @f1.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
       @f2 = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 15,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
      # @f2.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
 end


      @n = Orderchecklistitem.where(:OrderId => @order, :CheckListItemId => [2, 15])
@n.update_all(:IsComplete => true,:UpdateUserId => current_user.UserId, :UpdateTime => Time.now)


     # @order.Orderchecklistitems(2).update_attributes(:IsComplete => true)

respond_to do |format|
      if @order.update_attributes(params[:order])
#      session[:cart] = nil
      UserMailer.workvoice_email(@order).deliver
       format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
       format.xml  { head :ok }
        format.js
       #  format.js { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }

      else
      format.html { redirect_to :back }
       # format.html { render :action => :orderpad/edit }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
           format.js

      end
    end
      if @checkstatus == "1" and @order.Price == 0
      @order.update_attributes(:OrderStatusId => 3)
    elsif
        @checkstatus == "1" and @order.Price > 0
      @order.update_attributes(:OrderStatusId => 8)
      elsif
        @checkstatus == "2"
      @order.update_attributes(:OrderStatusId => 3)
      elsif
        @checkstatus == "3"
      @order.update_attributes(:OrderStatusId => 3)
      elsif
        @checkstatus == "4"
      @order.update_attributes(:OrderStatusId => 3)
      elsif @checkstatus == "5" and @order.Price == 0
      @order.update_attributes(:OrderStatusId => 3)

    else
        @checkstatus == "5" and @order.Price > 0
      @order.update_attributes(:OrderStatusId => 8)

    end

   else
     @use.each do |x|
    @useledger = Userledger.new(x)
   @useledger.update_attributes(:EntryDate => Time.now, :InsertTime => Time.now,:InsertUserId => current_user.UserId, :UserId => x.UserId, :Active => 1,
    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TotalAmount => 0, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
    :Charge => x.User.Usercommissionrate.Rate/@count*0)
    end

respond_to do |format|
      if @order.update_attributes(params[:order])
#      session[:cart] = nil
      #UserMailer.workvoice_email(@order).deliver
     #  format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
       format.xml  { head :ok }
         format.js# { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }

      else
     #   format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
      #format.html { redirect_to :back }
       # format.html { render :action => :orderpad/edit }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
           format.js

      end
    end
 
   end

  end
  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
def workorder
#t = Time.now
#@orders = Order.all(:limit => 1000)
 # @orders = 1256644

#Order.includes([:Schedule, :Contracts => :ContractType]).find(params[:id])

@Frank = Order.includes([:Schedule => :Routes],[:Contracts => :ContractType]).find(params[:id])
@sched = @Frank.Schedule
#@Rou = @sched.Routes
 #   Route.find(:all,
 # :include => [{:Schedules => {:Orders => [:Servicecode,{:Property => :Warranties}]}}],
 #   :conditions => ["Orders.OrderId = ?", @order] )

    respond_to do |format|
      format.html # index.html.erb
    end
  end
 
def coversheet
#@start = '9/23/2011'
  @start = params[:startdate]||=  Time.now.strftime("%m/%d/%Y")
#@start = Time.now.strftime("%m/%d/%Y")
@end = @start + " 11:59:00PM"
@user = current_user.UserId

#@cur =Rubyroute.where(["Rubyroute.UserId = 114"] )
@cur = Rubyroute.where("UserId = ?", @user)
#@cur = Route.joins(:Userroutes).where([" Userroutes.UserId = ? AND UserRoutes.Active = 1 AND UserRoutes.EndTime > ?", @user, Time.now] )
@hope = Route.find(@cur)
@sched = Order.includes(:Servicecode, :Orderstatus, :Schedule => :Scheduleroutes, :Property => :Address).where(["Orders.OrderStatusId != 4 AND Scheduleroutes.RouteId = ? AND Schedules.StartTime BETWEEN ? AND ?" , @hope, @start, @end])
 #@sched =Order.dayschedule

 #.find(:all).joins(:Servicecode, :Schedule => :Scheduleroutes, :Property => :Address).where(["Scheduleroutes.RouteId = ? AND Schedules.StartTime BETWEEN ? AND ?" , @hope, @start, @end])
@count = @sched.count()
@sum = @sched.sum("Price")
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def coversheetold
 t = Time.now
@start = params[:startdate]||=  t.strftime("%m/%d/%Y")

#@start = params[:startdate]||=  "4/22/2011"
@end = params[:startdate]+ " 11:59:00PM"
@user = current_user.UserId

@time_range = (Time.now.midnight-1.day)..( Time.now.midnight + 50.years)


    @rou = Route.joins(:Userroutes).where(:Userroutes => {:UserID => @user, :Active => 1, :EndTime =>  @time_range})



@hope = Route.find(@rou)
   
   @sched = @hope.Schedules.joins(:Order).where(["OrderStatusId != 4 AND Schedules.StartTime BETWEEN ? AND ?" , @start, @end, ])
@count = @sched.count()
@sum = @hope.Schedules.joins(:Order).where(["OrderStatusId != 4 AND Schedules.StartTime BETWEEN ? AND ?" , @start, @end, ]).sum("Price")
   
    respond_to do |format|
      format.html # index.html.erb

 

    end
  end

   
 def find_cart
    @cart = (session[:cart] ||= Cart.new)
  end
  #END:find_cart<
end
