class WoodreportsController < ApplicationController
  # GET /woodreports
  # GET /woodreports.xml
   layout 'orders'
  def index
    @woodreports = Woodreport.where(:PropertyID => 150753)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @woodreports }
    end
  end

  # GET /woodreports/1
  # GET /woodreports/1.xml
  def show
    @woodreport = Woodreport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @woodreport }
    end
  end

  # GET /woodreports/new
  # GET /woodreports/new.xml
  def new
    @woodreport = Woodreport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @woodreport }
    end
  end

  # GET /woodreports/1/edit
  def edit
    @woodreport = Woodreport.find(params[:id])
  end

  # POST /woodreports
  # POST /woodreports.xml
  def create
    @woodreport = Woodreport.new(params[:woodreport])

    respond_to do |format|
      if @woodreport.save
        format.html { redirect_to(@woodreport, :notice => 'Woodreport was successfully created.') }
        format.xml  { render :xml => @woodreport, :status => :created, :location => @woodreport }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @woodreport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /woodreports/1
  # PUT /woodreports/1.xml
  def update
    @woodreport = Woodreport.find(params[:id])

    respond_to do |format|
      if @woodreport.update_attributes(params[:woodreport])
        format.html { redirect_to(@woodreport, :notice => 'Woodreport was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @woodreport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /woodreports/1
  # DELETE /woodreports/1.xml
  def destroy
    @woodreport = Woodreport.find(params[:id])
    @woodreport.destroy

    respond_to do |format|
      format.html { redirect_to(woodreports_url) }
      format.xml  { head :ok }
    end
  end
end
