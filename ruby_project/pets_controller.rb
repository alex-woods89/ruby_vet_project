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

# show

# create

# edit

# UPDATE

# destroy
