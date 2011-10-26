class WarrantytypesController < ApplicationController
  # GET /warrantytypes
  # GET /warrantytypes.xml
  def index
    @warrantytypes = Warrantytype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @warrantytypes }
    end
  end

  # GET /warrantytypes/1
  # GET /warrantytypes/1.xml
  def show
    @warrantytype = Warrantytype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @warrantytype }
    end
  end

  # GET /warrantytypes/new
  # GET /warrantytypes/new.xml
  def new
    @warrantytype = Warrantytype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @warrantytype }
    end
  end

  # GET /warrantytypes/1/edit
  def edit
    @warrantytype = Warrantytype.find(params[:id])
  end

  # POST /warrantytypes
  # POST /warrantytypes.xml
  def create
    @warrantytype = Warrantytype.new(params[:warrantytype])

    respond_to do |format|
      if @warrantytype.save
        format.html { redirect_to(@warrantytype, :notice => 'Warrantytype was successfully created.') }
        format.xml  { render :xml => @warrantytype, :status => :created, :location => @warrantytype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @warrantytype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /warrantytypes/1
  # PUT /warrantytypes/1.xml
  def update
    @warrantytype = Warrantytype.find(params[:id])

    respond_to do |format|
      if @warrantytype.update_attributes(params[:warrantytype])
        format.html { redirect_to(@warrantytype, :notice => 'Warrantytype was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @warrantytype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /warrantytypes/1
  # DELETE /warrantytypes/1.xml
  def destroy
    @warrantytype = Warrantytype.find(params[:id])
    @warrantytype.destroy

    respond_to do |format|
      format.html { redirect_to(warrantytypes_url) }
      format.xml  { head :ok }
    end
  end
end
