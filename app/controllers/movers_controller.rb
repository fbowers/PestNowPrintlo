class MoversController < ApplicationController
  # GET /movers
  # GET /movers.xml
  def index
    @movers = Mover.all
render :layout => 'Main'
   # respond_to do |format|
    #  format.html # index.html.erb
     # format.xml  { render :xml => @movers }
   # end
  end

  # GET /movers/1
  # GET /movers/1.xml
  def show
    @mover = Mover.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mover }
    end
  end

  # GET /movers/new
  # GET /movers/new.xml
  def new
    @mover = Mover.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mover }
    end
  end

  # GET /movers/1/edit
  def edit
    @mover = Mover.find(params[:id])
  end

  # POST /movers
  # POST /movers.xml
  def create
    @mover = Mover.new(params[:mover])

    respond_to do |format|
      if @mover.save
        format.html { redirect_to(@mover, :notice => 'Mover was successfully created.') }
        format.xml  { render :xml => @mover, :status => :created, :location => @mover }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mover.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movers/1
  # PUT /movers/1.xml
  def update
    @mover = Mover.find(params[:id])

    respond_to do |format|
      if @mover.update_attributes(params[:mover])
        format.html { redirect_to(@mover, :notice => 'Mover was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mover.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movers/1
  # DELETE /movers/1.xml
  def destroy
    @mover = Mover.find(params[:id])
    @mover.destroy

    respond_to do |format|
      format.html { redirect_to(movers_url) }
      format.xml  { head :ok }
    end
  end
end
