require_relative('../db/sql_runner')

class Pet

attr_reader :id
attr_accessor :id, :name, :dob, :type_of_animal, :contact_details, :treatment_notes, :vet_id

def initialise(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @dob = options['dob']
  @type_of_animal = options['type_of_animal']
  @contact_details = options['contact_details']
  @treatment_notes = options['treatment_notes']
  @vet_id = options['vet_id'].to_i
end

end
