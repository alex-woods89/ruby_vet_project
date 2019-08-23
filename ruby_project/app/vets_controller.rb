require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/pet')
require_relative('../models/vet')
also_reload('../models/*')

get '/vets' do
  @vets = Vet.all
end
