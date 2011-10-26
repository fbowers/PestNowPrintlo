class WarrantiesController < ApplicationController
  # GET /warranties
  # GET /warranties.xml
    layout 'orders'
  def index
    @warranties = Warranty.limit(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @warranties }
    end
  end

  # GET /warranties/1
  # GET /warranties/1.xml
  def show
    @warranty = Warranty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @warranty }
    end
  end

  # GET /warranties/new
  # GET /warranties/new.xml
  def new
    @warranty = Warranty.new
    t = Time.now
    #tt = Time.now.advance(:years => 1).end_of_month.strftime("%m/%d/%y")
  #  tt = Time.now.end_of_month.strftime("%m/%d/%y")
  #  @start = params[:StartDate]||=  t.strftime("%m/%d/%Y")
  #  @end = params[:EndDate]||=  tt

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @warranty }
    end
  end

  # GET /warranties/1/edit
  def edit
    @warranty = Warranty.find(params[:id])
  end

  # POST /warranties
  # POST /warranties.xml
  def create
    @warranty = Warranty.new(params[:warranty])
     @warranty.update_attributes(:InsertUserId => current_user.UserId)
     @warranty.update_attributes(:Active => 1)
     @warranty.update_attributes(:SoldBy => current_user.UserId)
     @warranty.update_attributes(:StartDate => Time.now)
      @warranty.update_attributes(:EndDate => Time.now  + 12.month   )


    respond_to do |format|
      if @warranty.save
        format.html { redirect_to(:back, :notice => 'Warranty was successfully created.') }
        format.xml  { render :xml => @warranty, :status => :created, :location => @warranty }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @warranty.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /warranties/1
  # PUT /warranties/1.xml
  def update
    @warranty = Warranty.find(params[:id])

     @warranty.update_attributes(:UpdateUserId => current_user.UserId)
     @warranty.update_attributes(:UpdateTime => Time.now)
    #  @warranty.update_attributes(:PropertyID => @warranty.PropertyId )

    respond_to do |format|
      if @warranty.update_attributes(params[:warranty])
        format.html { redirect_to(:back, :notice => 'Warranty was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @warranty.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /warranties/1
  # DELETE /warranties/1.xml
  def destroy
    @warranty = Warranty.find(params[:id])
    @warranty.destroy

    respond_to do |format|
      format.html { redirect_to(warranties_url) }
      format.xml  { head :ok }
    end
  end
end
