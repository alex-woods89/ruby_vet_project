require_relative('../db/sql_runner')


class Vet

  attr_reader :id
  attr_accessor :name, :specialism, :consultation_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @specialism = options['specialism']
    @consultation_id = options['consultation_id']
  end

  def save()
    sql = "INSERT INTO vets(name, specialism, consultation_id)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@name, @specialism, @consultation_id]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def update()
    sql = "UPDATE vets
    SET
    (
      name, specialism, consultation_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@name, @specialism, @consultation_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM vets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def consultation
    consultation = Consultation.find(@consultation_id)
    return consultation
  end


  def self.delete_all
    sql = 'DELETE FROM vets'
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM vets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    vet = Vet.new(result)
    return vet
  end

  def self.all()
    sql = "SELECT * FROM vets"
    vet_data = SqlRunner.run(sql)
    vets = map_items(vet_data)
    return vets
  end

  def self.map_items(vet_data)
    return vet_data.map { |vet| Vet.new(vet) }
  end

end
