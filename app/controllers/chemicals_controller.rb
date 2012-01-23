class ChemicalsController < ApplicationController
  # GET /orderpads
  # GET /orderpads.xml
  respond_to :html, :xml, :json
 # respond_to :html, :js
 # layout 'orderpads'
 #  layout "orders", :except => :map
 # before_filter :require_user
   #   layout 'orders'
   #   before_filter :find_cart, :except => :empty_cart


  def index
    @chemicals = Chemical.all

    respond_with(@chemicals)
  end
end
