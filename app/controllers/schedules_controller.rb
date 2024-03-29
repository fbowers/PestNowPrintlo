class SchedulesController < ApplicationController
  # GET /schedules
  # GET /schedules.xml
  def index
    @schedule = Schedule.all(  :conditions => ["Schedules.StartTime BETWEEN '12/20/2010' AND '12/25/2010' "], :limit => 10)

   
@pro1 = Schedule.all(
                              :joins => [:Scheduleroutes, :Order, :Routes ],
                              :select => "Scheduleroutes.*, Schedules.*, Orders.*, Routes.* ",
                              #:conditions => ["Schedules.StartTime BETWEEN ? AND ? AND Routes.Routename = ? ", @start, @end, params[:name]] ,
                               :conditions => ["Schedules.StartTime BETWEEN '12/20/2010' AND '12/25/2010' "] ,
                             :order => "Routename",
                              :limit => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.xml
  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.xml
  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully created.') }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.xml
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.xml
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
end
