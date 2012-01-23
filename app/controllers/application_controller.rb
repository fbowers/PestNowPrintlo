class ApplicationController < ActionController::Base


  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
   rescue_from ActiveRecord::StatementInvalid, :with => :record_not_found



  private

  def record_not_found
   # render :text => "404 Not Found", :status => 404
  #   flash[:error] = "You have entered the wrong information. Please make sure it is correct."
     flash[:notice] ="You have entered the wrong information. Please make sure it is correct."

    redirect_to :back
  end
#   protect_from_forgery
#
#  private
#def current_cart
#Cart.find(session[:cart_id])
#rescue ActiveRecord::RecordNotFound
#cart = Cart.create
#session[:cart_id] = cart.id
#cart
#end
#
#
  helper_method :current_user_session, :current_user
#
   private



     def current_user_session
     #  logger.debug "ApplicationController::current_user_session"
       return @current_user_session if defined?(@current_user_session)
       @current_user_session = UserSession.find
     end

     def current_user
      # logger.debug "ApplicationController::current_user"
       return @current_user if defined?(@current_user)
       @current_user = current_user_session && current_user_session.user
     end
#
#     def require_user
#       logger.debug "ApplicationController::require_user"
#       unless current_user
#         store_location
#         flash[:notice] = "You must be logged in to access this page"
#         redirect_to new_user_session_url
#         return false
#       end
#     end
#
#     def require_no_user
#
#      logger.debug "ApplicationController::require_no_user"
#       if current_user
#         store_location
#         flash[:notice] = "You must be logged out to access this page"
#        redirect_to account_url
#         return false
#       end
#     end
#
# def store_location
#      session[:return_to] = request.request_uri
#    end
#    def store_location
#     session[:return_to] = request.request_url
#
#     end
#
#
#     def redirect_back_or_default(default)
#
#       redirect_to(session[:return_to] || default)
#
#       session[:return_to] = nil
#
#     end

 end
