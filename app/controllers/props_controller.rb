class PropsController < ApplicationController
  # GET /props
  # GET /props.xml
  def index
   #@props = Prop.all


#@props = Prop.all(:joins => [:Address, :Orders],
 #                               #:include => [:order, :route],
  #                              :select => "Properties.*, Addresses.*, Orders.*",
   #                             :conditions => "Properties.PropertyID < 100",
    #                           # :order => "Property.PropertyId desc",
     #                           :limit => 100)

    @props = Prop.all(:joins => [:Address],
                                #:include => [:order, :route],
                                :select => "Properties.*, Addresses.*",
                               # :conditions => "Schedules.StartTime BETWEEN '9/1/2009' AND '9/30/2009' AND ServiceCodes.Code = 'wdi'",
                               # :order => "Property.PropertyId desc",
                                :limit => 100)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @props }
    end
  end

  # GET /props/1
  # GET /props/1.xml
  def show
    @prop = Prop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prop }
    end
  end

  # GET /props/new
  # GET /props/new.xml
  def new
    @prop = Prop.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prop }
    end
  end

  # GET /props/1/edit
  def edit
    @prop = Prop.find(params[:id])
  end

  # POST /props
  # POST /props.xml
  def create
    @prop = Prop.new(params[:prop])

    respond_to do |format|
      if @prop.save
        format.html { redirect_to(@prop, :notice => 'Prop was successfully created.') }
        format.xml  { render :xml => @prop, :status => :created, :location => @prop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /props/1
  # PUT /props/1.xml
  def update
    @prop = Prop.find(params[:id])

    respond_to do |format|
      if @prop.update_attributes(params[:prop])
        format.html { redirect_to(@prop, :notice => 'Prop was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /props/1
  # DELETE /props/1.xml
  def destroy
    @prop = Prop.find(params[:id])
    @prop.destroy

    respond_to do |format|
      format.html { redirect_to(props_url) }
      format.xml  { head :ok }
    end
  end
end
