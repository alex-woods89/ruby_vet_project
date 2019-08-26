require('sinatra')
require('sinatra/contrib/all')
require('sinatra/reloader')
require_relative('./models/pet')
require_relative('./models/customer')
also_reload('./models/*')
require ('pry')

# index
get '/customer' do
  @customer = Customer.all
  erb(:"customer/index")
end
# new
get '/customer/new' do
  @pets = Pet.all
  erb(:"customer/new")
end
# show
get '/customer/:id' do
  @customer = Customer.find( params[:id])
  erb(:"customer/show")
end
# create
post '/customer' do
  @customer = Customer.new( params )
  @customer.save
  erb(:"customer/create")
end

# edit
get '/customer/:id/edit' do
  @customer = Customer.find(params[:id])
  @pets = Pet.all
  erb (:"customer/edit")
end
# UPDATE
post '/customer/:id' do
  Customer.new( params ).update
  redirect to '/customer'
end
# destroy
post '/customer/:id/delete' do
  customer = Customer.find( params[:id])
  customer.delete
  redirect to '/customer'
end
