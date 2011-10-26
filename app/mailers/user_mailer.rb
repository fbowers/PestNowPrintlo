class UserMailer < ActionMailer::Base
  default :from => "franchising@pestnow.com"

  def welcome_email(user)
    @user = "fbowers@pestnow.com"
    @url  = "http://216.177.62.21:8080/wdi.pdf"
    mail(:to => "fbowers@pestnow.com",
      :subject => "Welcome to My Awesome Site")
  end


  def workorder_email(order)
   #  @orderpad = Order.find(params[:id])
    @order = order

    @url  = "http://216.177.62.21:8080/wdi.pdf"
   # @email = Customer.where(:CustomerId => @orderpad.CustomerId)
    mail(:to => "fbowers@pestnow.com",
      :subject => "Your WorkOrder")
  end

def workvoice_email(order)
@chem = Orderchemical.where(:OrderId => order)
@order = order
#@oid = order.find(params[:id])
@inv = order
#.includes(:Servicecode, :Schedule, :Property, :Customer, :Customerledgerorders).find(order)
#@presum = order.find(:all,
 # :conditions => ["OrderCopiedFrom = ?", @oid])
@balance = order.Customerledgerorders.sum("Charge")+order.Customerledgerorders.sum("TaxCharge")- order.Customerledgerorders.sum("Deposit")
@taxsum = order.Customerledgerorders.sum("TaxCharge")
@sub = order.Customerledgerorders.includes(:Order => [:Servicecode, :Schedule]).limit(10)
 @url = "http://localhost:3000/printing/workvoice/1320504"
 @url2 = "http://localhost:3000/printing/workvoice/"
 mail(:to => "fbowers@pestnow.com",
      :subject => "Your WorkOrder")
end

def new_project(project, followers)
#   @followers = ["fbowers@pestnow.com" "frank.bowers@gmail.com" "fbowers@pestnow.com" "info@pestnow.com"]
  #@project.owner.followers.all

    @u = User.find(f.follower)
    mail(:to => @u.email,
         :from => '"frank the tank" <fbowers@pestnow.com>',
         :subject => "#{project.owner.name} created a new project")
end


#end
end


