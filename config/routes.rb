PestNowPrint::Application.routes.draw do
  match "/application.manifest" => Rails::Offline
  resources :purchases
  resources :ordercheckcomments
  resources :orderchemicals
  resources :orderpests
  resources :orderequipments
  resources :schedules
  resources :areatreateds
  resources :orders
  resources :orderareas
  resources :carts

  resources :warranties

  resources :contracttypes

  resources :contracts

   resources :printing

  resources :woodreports

   resources :locate
   
  resources :wdireports

  resources :orderpads

  resources :rusers

  resources :rbillcustomers

resources :histories

  resources :warrantytypes

  resources :branches

  resources :routes

   resources :printing


#match ':controller(/:action(/:id))'

  #resources :scheduleroutes
  #   resources :servicecodes

    
#  #resources :orders, :workorder
match "profile" => "orders#workorder"

#match "spike" => "orders#update"

 # match "frank" => "orders#fworkorder"
#resources "orderpads#service"
  match "service" => "orderpads#service"
 #  match "oc/:oid" => "orderpads#oc"
   match "oc" => "orderpads#oc"
  match "test" => "orderpads#test"
#match "/orderpads/details/:id" => "orderpads#details"

  match "invoice" => "orders#invoice"

   match "bulk" => "orders#index"
   match "stest" => "printing#stest"

 #  match "workvoice" => "printing#workvoice"
   match "look" => "orders#coversheetchecked"
   match "coversheet" => "orders#coversheet", :as => :coversheet
    match "map" => "orderpads#map"#, :as => :coversheet



match "workorder" => "orders#workorder"
   match "contractdetails" => "orders#contract"
#  match "wdi" => "orders#wdireport"
 # match "wdi" => ""
#resources :wdi, :controller => :wdireports


#  resources :properties do
#    resources :orders
#  end
  
  # resources :routes do
  #  resources :schedules
  #end
#resources "orders#workorder"
#match 'workorder/:id' => 'orders#workorder'
 # resources "orders#workorder"
# resources "orders#fworkorder"
# match "contract" => "orders#contracter"
  resources :user_session, :controller => :user_session
#resources :user_session
  resources :users, :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

match '/:controller(/:action(/:id))'
    match ':controller/:action/:id/:pid'

 
 #  match '/select_size', :controller => 'payments', :action => 'select_size', :conditions => {:method => :get}
 #  match '/review_order', :controller => 'payments', :action => 'review', :conditions => {:method => :post}
 #  match '/payment', :controller => 'payments', :action => 'payment', :conditions => {:method => :post}
 #  match '/relay_response', :controller => 'payments', :action => 'relay_response', :conditions => {:method => :post}
 #  match '/receipt', :controller => 'payments', :action => 'receipt', :conditions => {:method => :get}
 #  match '/error', :controller => 'payments', :action => 'error', :conditions => {:method => :get}
 #  match '/test', :controller => 'payments', :action => 'test', :conditions => {:method => :post}



  #resources :user_sessions
#get 'user_sessions/new'
#match 'login' => "user_sessions#new",      :as => :login
#match 'logout' => "user_sessions#destroy", :as => :logout

 # resources :user_sessions
 # root :controller => "user_sessions", :action => "new" # optional, this just sets the root route
  root :to => 'user_sessions#new'
  #root :to => "user_sessions#new"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
