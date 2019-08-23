require_relative('../models/vet')
require_relative('../models/pet')

vet1 = Vet.new({'name' => 'Jim Smith'})
vet2 = Vet.new({'name' => 'Sarah Brown'})

vet1.save
vet2.save


pet1 = Pet.new({
  'name' => 'Tiddles',
  'dob' => '1/6/12',
  'type_of_animal' => 'cat',
  'contact_details' => 'tiddles@icloud.com',
  'treatment_notes' => 'sore head prescribed paracetamol',
  'vet_id' => '1'
  })


  pet2 = Pet.new({
    'name' => 'Billy',
    'dob' => '1/7/15',
    'type_of_animal' => 'cat',
    'contact_details' => 'Billy@hotmail.com',
    'treatment_notes' => 'sore leg prescribed paracetamol',
    'vet_id' => '2'
    })
  pet1.save
  pet2.save
