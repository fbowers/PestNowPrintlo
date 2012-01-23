class RailscoversheetsController < ApplicationController

  respond_to :html, :xml, :json



   def update


    @checkstatus = params[:checkstatus]
    @tin = params[:tin] || Time.now
    @order = Order.find(params[:id])

    @order.update_attributes(:UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :TimeIn => @tin, :TimeOut => Time.now, :CheckInResultId => @checkstatus  )



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
 @useledger = Userledger.create(:UserId => x.UserId, :EntryDate => @now,:InsertTime => @now,:InsertUserId => current_user.UserId, :Active => 1, :Note => "Serv",
    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TotalAmount => @price, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
    :Charge => x.User.Usercommissionrate.Rate/@count*@price )

    end


   #   if @order.Customer.AutoPay == false
   #   @order.update_attributes(:UpdateReason => "no auto pay" )
   #     else
   #        @order.update_attributes(:UpdateReason => "Yes auto pay" )

   #   end


if @order.SoldBy == nil
flash[:notice] = "S"

  else


    @soldby = @order.SoldBy || nil
    @soldbyrate = @order.Usercommissionrate.Rate || nil
    @sales = Userledger.create(:EntryDate => @now, :InsertTime => @now,:InsertUserId => current_user.UserId, :UserId => @soldby, :Active => 1, :Note => "Sales", :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now,:UpdateReason => "Entry From Road App",
    :TotalAmount => @price, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*@price)

end

@con = @order.Property.Contracts
@con2 =  @order.Contract

      if @order.ContractId == nil
        flash[:notice] = "no contract"
              else
        @iscon = @con.find(@order.ContractId)
        @iscon.update_attributes(:ServiceDate => Time.now)
      end


      if @order.Servicecode.CreatesContract == false# or @soldby == nil# or @order.Contract.Frequency.Days == 0

flash[:notice] = "S"

      else if
        @order.Servicecode.CreatesContract == true and @con2.Frequency.Days == 0


@con2.update_attributes(:Active => 1, :Proposed => 0, :StartDate => Time.now, :ServiceDate => Time.now)
 else if
            @order.Servicecode.CreatesContract == true and @soldby == nil
#@con = @order.Property.Contracts
@con2.update_attributes(:Active => 1, :Proposed => false, :StartDate => Time.now, :ServiceDate => Time.now)
  else
@recur = @order.Contract.RecurringPrice
  #  @con = @order.Contract
    @freq = (365/(@order.Contract.Frequency.Days)) -1
    @soldby = @order.SoldBy || nil
    @soldbyrate = @order.Usercommissionrate.Rate || nil
    @sales = Userledger.create(:EntryDate => @now,:InsertUserId => current_user.UserId, :UserId => @soldby, :Active => 1, :OrderId => (params[:id]), :InsertTime => @now, :UpdateUserId => current_user.UserId, :UpdateTime => @now,:UpdateReason => "Reccuring Entry From Road App",
    :TotalAmount => @recur*@freq, :CommissionRateApplied =>  @soldbyrate, :Charge => @soldbyrate*(@recur*@freq))

   @con2.update_attributes(:Active => 1, :Proposed => false, :StartDate => @now, :ServiceDate => @now)

end
end
      end




    @L = Customerledger.create(:EntryDate => @now, :InsertTime => @now, :Active => 1,:PropertyId => @order.PropertyId || nil, :AgentId => @order.AgentId || nil, :CustomerId => @order.CustomerId || nil,
   :SettlementCompanyId => @order.SettlementCompanyId || nil, :Charge => @price, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => @now, :TaxCharge => @tax, :TaxRate => @taxrate, :UpdateReason => "Entry From Road App", :Coupon => false, :LedgerCategoryId => 1)


    @LD = @L.LedgerId

   @CL= Customerledgerorder.create(:InsertTime => @now, :LedgerId => @LD,:OrderId => @order.OrderId, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => @now, :UpdateReason => "Entry From Road App", :TaxCharge => @tax, :TaxRate => @taxrate, :Deposit => 0, :Charge => @price )




    if not  @order.Orderchecklistitems.detect{|el| el.CheckListItemId == 1}

       # flash[:notice] = "Already has Check list"

   #  else
    Orderchecklistitem.create(:OrderId => @order.OrderId, :CheckListItemId => 1,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)

      #  @f = Orderchecklistitem.new(:OrderId => @order.OrderId, :CheckListItemId => 1,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
      # @f.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
     Orderchecklistitem.create(:OrderId => @order.OrderId, :CheckListItemId => 2,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
    #   @f1.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
    Orderchecklistitem.create(:OrderId => @order.OrderId, :CheckListItemId => 15,  :Ignore=> false, :Optional => false, :DateCompleted => Time.now, :InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
       #@f2.update_attributes(:InsertTime => Time.now, :InsertUserId => current_user.UserId, :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :IsComplete => true)
 end


      @n = Orderchecklistitem.where(:OrderId => @order, :CheckListItemId => [2, 15])
@n.update_all(:IsComplete => true,:UpdateUserId => current_user.UserId, :UpdateTime => Time.now)


     # @order.Orderchecklistitems(2).update_attributes(:IsComplete => true)

respond_to do |format|
      if @order.update_attributes(params[:order])
#      session[:cart] = nil
    #  UserMailer.workvoice_email(@order).deliver
    #   format.html { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }
    #   format.xml  { head :ok }
        format.js
       #  format.js { redirect_to(:coversheet, :notice => 'Order was successfully checked in.') }

      else
      format.html { redirect_to :back }
       # format.html { render :action => :orderpad/edit }
     #   format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
           format.js

      end
end
    @balance = @order.Customerledgerorders.sum("Charge")+@order.Customerledgerorders.sum("TaxCharge")- @order.Customerledgerorders.sum("Deposit")
      if @checkstatus == "1" and @balance == 0
      @order.update_attributes(:OrderStatusId => 3)
     # elsif
     # @balance = 0
      #@checkstatus == "1" and @order.OrderStatusId == 3
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
     # elsif @checkstatus == "5" and @order.Price == 0
      elsif @checkstatus == "5" and @balance == 0

        @order.update_attributes(:OrderStatusId => 3)

        elsif @checkstatus == "5" and @order.OrderStatusId == 3
      @order.update_attributes(:OrderStatusId => 14)

    else
        @checkstatus == "5" and @order.Price > 0
      @order.update_attributes(:OrderStatusId => 8)

    end

   else

     @use.each do |x|
     @useledger = Userledger.create(:UserId => x.UserId, :EntryDate => @now,:InsertTime => @now,:InsertUserId => current_user.UserId, :Active => 1, :Note => "Serv",
    :OrderId => (params[:id]), :UpdateUserId => current_user.UserId, :UpdateTime => Time.now, :UpdateReason => "Entry From Road App", :TotalAmount => 0, :CommissionRateApplied => x.User.Usercommissionrate.Rate/@count,
    :Charge => x.User.Usercommissionrate.Rate/@count*@price )


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
end
