require_relative('../models/vet')
require_relative('../models/pet')

vet1 = Vet.new({'name' => 'Jim Smith'})
vet2 = Vet.new({'name' => 'Sarah Brown'})

vet1.save
vet2.save
