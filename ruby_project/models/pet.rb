require_relative('../db/sql_runner')

class Pet

attr_accessor :id, :name, :dob, :type_of_animal, :treatment_notes, :vet_id, :customer_id, :consultation_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @dob = options['dob']
  @type_of_animal = options['type_of_animal']
  @treatment_notes = options['treatment_notes']
  @vet_id = options['vet_id'].to_i
  @customer_id = options['customer_id'].to_i
  @consultation_id = options['consultation_id'].to_i
end

def save()
    sql = "INSERT INTO pets
    (
      name,
      dob,
      type_of_animal,
      treatment_notes,
      vet_id,
      customer_id,
      consultation_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5,$6, $7
    )
    RETURNING id"
    values = [@name, @dob, @type_of_animal, @treatment_notes, @vet_id, @customer_id, @consultation_id]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def vet()
    vet = Vet.find(@vet_id)
    return vet
  end

  def customer()
    customer = Customer.find(@customer_id)
    return customer
  end

  def consultation
    consultation = Consultation.find(@consultation_id)
    return consultation
  end

  def update()
    sql = "UPDATE pets
    SET
    (
      name,
      dob,
      type_of_animal,
      treatment_notes,
      vet_id,
      customer_id,
      consultation_id
    ) =
    (
      $1, $2, $3, $4, $5, $6, $7
    )
    WHERE id = $8"
    values = [@name, @dob, @type_of_animal, @treatment_notes, @vet_id, @customer_id, @consultation_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM pets"
    pet_data = SqlRunner.run(sql)
    pets = map_items(pet_data)
    return pets
  end

  def self.map_items(pet_data)
    return pet_data.map { |pet| Pet.new(pet) }
  end

  def self.find(id)
    sql = "SELECT * FROM pets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    pet = Pet.new(result)
    return pet
  end



end
