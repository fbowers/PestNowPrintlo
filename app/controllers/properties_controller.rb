class PropertiesController < ApplicationController
  # GET /properties
  # GET /properties.xml
  def index
   # @properties = Property.all
      @movers = Mover.all
	render :layout => 'Main'

  
  #  respond_to do |format|
   #   format.html # index.html.erb
    #  format.xml  { render :xml => @properties }
   # end
  end

  # GET /properties/1
  # GET /properties/1.xml
  def data
		columns = ['PropertyId', 'StreetNumber','Direction','Street','UnitNumber', 'City','Stateid','ZipCodeId']
		sorting = DatatableHelper.get_sorting(columns, params)
		data = Property.query(params['sSearch'], sorting, params[:iDisplayLength].to_i, params[:iDisplayStart].to_i)
   # data = Prop.all(params['sSearch'], sorting, params[:iDisplayLength].to_i, params[:iDisplayStart].to_i, #:joins => [:order, :route],
   #                             #:include => [:order, :route],
   #                             :select=>'PropertyId, CustomerId, OwnerId, AddressId',
   #                            :conditions=>['PropertyId = :q OR CustomerId like :ql', {:q=>args.first, :ql=>"%#{args.first}%"}],
   #                           	:order=>args.second,
   #                             :limit=>args.third,
   #                             :offset=>args.fourth)
   		total = Property.query_total(params['sSearch'])
		render :text => DatatableHelper.to_table(data, :columns=>columns, :total=>total)
	end
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.xml
  def new
    @property = Property.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
   #@property = Property.frank.find(params[:id])


    # @property = Property.find(params[:id], :include => 'Address')
   #@address = Address.all
    #@ad = Address.all
    #@order = Order.find(params[:id])
		#	@property = @order.property
   # @addresses = @property.Address
    #@address = @property.Addresses
  end

  # POST /properties
  # POST /properties.xml
  def create
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
        format.html { redirect_to(@property, :notice => 'Property was successfully created.') }
        format.xml  { render :xml => @property, :status => :created, :location => @property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.xml
  def update2
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to(@property, :notice => 'Property was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to(orders_url, :notice => 'Prpoerty was successfully updated.') }

        #format.html { redirect_to(@vehicle, :notice => 'Vehicle was successfully updated.') }
        format.xml  { head :ok }
      else
        #format.html { redirect_to(@vehicle, :notice => 'There is a problem updated.') }
        format.html { render :action => "edit" }
        format.xml  { render :xml => @properties.errors, :status => :unprocessable_entity }
      end
    end
  end
  end

 


  # DELETE /properties/1
  # DELETE /properties/1.xml
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to(properties_url) }
      format.xml  { head :ok }
    end
  end

