require('sinatra')
require('sinatra/contrib/all')
require('sinatra/reloader')
require_relative('../models/pet')
require_relative('../models/customer')
require_relative('../models/vet')
also_reload('../models/*')
require ('pry')

# index
get '/consultation' do
  @consultation = Consultation.all
  erb(:"consultation/index")
end
# new
get '/consultation/new' do
  @pets = Pet.all
  erb(:"consultation/new")
end
# show
get '/consultation/:id' do
  @consultation = Consultation.find( params[:id])
  @pets = Pet.all
  @vets = Vet.all
  erb(:"consultation/show")
end
# create
post '/consultation' do
  @consultation = Consultation.new( params )
  @consultation.save
  erb(:"consultation/create")
end

# edit
get '/consultation/:id/edit' do
  @consultation = Consultation.find(params[:id])
  @pets = Pet.all
  erb (:"consultation/edit")
end
# UPDATE
post '/consultation/:id' do
  Consultation.new( params ).update
  redirect to '/consultation'
end
# destroy
post '/consultation/:id/delete' do
  consultation = Consultation.find( params[:id])
  consultation.delete
  redirect to '/consultation'
end
