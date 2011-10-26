class WdireportsController < ApplicationController
  # GET /wdireports
  # GET /wdireports.xml
  def index
    @wdireport = WDI.limit(10).where("PropertyID = 150753")

#@wdiid =214671
#   @wdi = WDI.includes([:User],[{:Order => [:Schedule, :Property] }]).find(@wdiid)

#@oid = @wdi.OriginatingOrderId
#@inv = Order.includes(:Servicecode, :Schedule, :Property, :Customer, :Customerledgerorders).find(1294310)
#@presum = Order.where("OrderCopiedFrom =?", @oid)
#@balance = Customerledgerorder.where("OrderId in (?)", @presum).sum("Charge")+@inv.Customerledgerorders.sum("TaxCharge")- @inv.Customerledgerorders.sum("Deposit")
#@taxsum =Customerledgerorder.where("OrderId in (?)", @presum).sum("TaxCharge")
#@sub = Customerledgerorder.limit(10).includes(:Order => [:Servicecode, :Schedule]).where("OrderId in (?)", @presum)



   respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @routes }
    end
  end




  # GET /wdireports/1
  # GET /wdireports/1.xml

  def show
    @wdireport = Wdireport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wdireport }
    end
  end
  
  def new
    @wdireport = Wdireport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wdireport }
    end
  end

  # GET /wdireports/1/edit
  def edit
    @wdireport = Wdireport.find(params[:id])
  end

  # POST /wdireports
  # POST /wdireports.xml
  def create
    @wdireport = Wdireport.new(params[:wdireport])

    respond_to do |format|
      if @wdireport.save
        format.html { redirect_to(@wdireport, :notice => 'Wdireport was successfully created.') }
        format.xml  { render :xml => @wdireport, :status => :created, :location => @wdireport }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wdireport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wdireports/1
  # PUT /wdireports/1.xml
  def update
    @wdireport = Wdireport.find(params[:id])

    respond_to do |format|
      if @wdireport.update_attributes(params[:id])
        format.html { redirect_to(@wdireport, :notice => 'Wdireport was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wdireport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wdireports/1
  # DELETE /wdireports/1.xml
  def destroy
    @wdireport = Wdireport.find(params[:id])
    @wdireport.destroy

    respond_to do |format|
      format.html { redirect_to(wdireports_url) }
      format.xml  { head :ok }
    end
  end
end
