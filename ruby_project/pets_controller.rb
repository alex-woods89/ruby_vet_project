require('sinatra')
require('sinatra/contrib/all')
require('sinatra/reloader')
require_relative('./models/pet')
require_relative('./models/vet')
also_reload('./models/*')

# index
get '/pets' do
  @pets = Pet.all
  erb(:index)
end
# new
get '/pets/new' do
  @vets = Vet.all
  erb(:new)
end
# show
get '/pets/:id' do
  @pet = Pet.find( params[:id])
  erb(:show)
end
# create
post '/pets' do
  @pet = Pet.new( params )
  @pet.save
  erb(:create)
end

# edit
get '/pets/:id/edit' do
  @pet = Pet.find(params[:id])
  @vets = Vet.all
  erb (:edit)
end
# UPDATE
post '/pets/:id' do
  Pet.new( params ).update
  redirect to '/pets'
end
# destroy
post '/pets/:id/delete' do
  pet = Pet.find( params[:id])
  pet.delete
  redirect to '/pets'
end
