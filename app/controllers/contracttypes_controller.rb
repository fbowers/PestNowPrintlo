class ContracttypesController < ApplicationController
  # GET /contracttypes
  # GET /contracttypes.xml
  def index
    @contracttypes = Contracttype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contracttypes }
    end
  end

  # GET /contracttypes/1
  # GET /contracttypes/1.xml
  def show
    @contracttype = Contracttype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contracttype }
    end
  end

  # GET /contracttypes/new
  # GET /contracttypes/new.xml
  def new
    @contracttype = Contracttype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contracttype }
    end
  end

  # GET /contracttypes/1/edit
  def edit
    @contracttype = Contracttype.find(params[:id])
  end

  # POST /contracttypes
  # POST /contracttypes.xml
  def create
    @contracttype = Contracttype.new(params[:contracttype])

    respond_to do |format|
      if @contracttype.save
        format.html { redirect_to(@contracttype, :notice => 'Contracttype was successfully created.') }
        format.xml  { render :xml => @contracttype, :status => :created, :location => @contracttype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contracttype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contracttypes/1
  # PUT /contracttypes/1.xml
  def update
    @contracttype = Contracttype.find(params[:id])

    respond_to do |format|
      if @contracttype.update_attributes(params[:contracttype])
        format.html { redirect_to(@contracttype, :notice => 'Contracttype was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contracttype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contracttypes/1
  # DELETE /contracttypes/1.xml
  def destroy
    @contracttype = Contracttype.find(params[:id])
    @contracttype.destroy

    respond_to do |format|
      format.html { redirect_to(contracttypes_url) }
      format.xml  { head :ok }
    end
  end
end
