class OrderchemicalsController < ApplicationController
  # GET /orderchemicals
  # GET /orderchemicals.xml
 # layout 'orderpads'
   respond_to :html, :json
  def index
    #@orderchemicals = Orderchemical.limit(10).order("OrderChemicalId DESC")
     @orderchemicals = Orderchemical.find(params[:id])
  
    respond_with(@orderchemicals)
  #  respond_to do |format|
  #    format.html # index.html.erb
   #   format.xml  { render :xml => @orderchemicals }
   # end
  end

  # GET /orderchemicals/1
  # GET /orderchemicals/1.xml
  def show
    @orderchemical = Orderchemical.find(params[:id])
  

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orderchemical }
    end
  end

  # GET /orderchemicals/new
  # GET /orderchemicals/new.xml
  def new
    @orderchemical = Orderchemical.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orderchemical }
    end
  end

  # GET /orderchemicals/1/edit
  def edit
    @orderchemical = Orderchemical.find(params[:id])
  end

  # POST /orderchemicals
  # POST /orderchemicals.xml
  def create
     Orderchemical.create(:OrderId => params[:OrderId], :ChemId => params[:ChemId], :Quantity => params[:Quantity])#!(params[:OrderId])
     render :nothing => true
     #redirect_to :back
  end

  # PUT /orderchemicals/1
  # PUT /orderchemicals/1.xml
  def update
    @orderchemical = Orderchemical.find(params[:id])

    respond_to do |format|
      if @orderchemical.update_attributes(params[:orderchemical])
        format.html { redirect_to(@orderchemical, :notice => 'Orderchemical was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orderchemical.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orderchemicals/1
  # DELETE /orderchemicals/1.xml
  def destroy
    @orderchemical = Orderchemical.find(params[:id])
    @orderchemical.destroy
#redirect_to :action => 'index'
    respond_to do |format|
    #  format.html { redirect_to(coversheet_url) }
    #  format.html { redirect_to :back }
     #format.html {redirect_to :action => 'index'}
      format.xml  { head :ok }
      
    end
  end
end
