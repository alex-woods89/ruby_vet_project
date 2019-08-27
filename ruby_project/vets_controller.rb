require('sinatra')
require('sinatra/contrib/all')
require('sinatra/reloader')
require_relative('./models/pet')
require_relative('./models/vet')
also_reload('./models/*')

# index
get '/vets' do
  @vets = Vet.all
  erb(:index)
end
# new
get '/vets/new' do
  @vets = Vet.all
  erb(:new)
end
# show
get '/vets/:id' do
  @vet = Vet.find( params[:id])
  erb(:show)
end
# create
post '/vets' do
  @vet = Vet.new( params )
  @vet.save
  erb(:create)
end

# edit
get '/vets/:id/edit' do
  @vet = Vet.find(params[:id])
  @pets = Pet.all
  erb (:edit)
end
# UPDATE
post '/vets/:id' do
  Vet.new( params ).update
  redirect to '/vets'
end
# destroy
post '/vets/:id/delete' do
  vet = Vet.find( params[:id])
  vet.delete
  redirect to '/vets'
end
