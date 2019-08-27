class Consultation

attr_accessor :id, :consultation_time, :treatment

def initialize(options)
 @id = options['id'].to_i if options['id']
 @consultation_time = options['consultation_time']
 @treatment = options['treatment']
end

def save()
  sql = "INSERT INTO consultations
  (consultation_time, treatment)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@consultation_time, @treatment]
  result = SqlRunner.run(sql, values)
  id = result.first['id']
  @id = id
end

def update()
  sql = "UPDATE consultations
  SET (consultation_time, treatment)
  =
  ($1, $2)
  WHERE id = $3"
  values = [@consultation_time, @treatment, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM consultations
        where id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM consultations"
  consultation_data = SqlRunner.run(sql)
  consultation = map_items(consultation_data)
  return consultation
end

def self.map_items(consultation_data)
  return consultation_data.map { |consultation| Consultation.new(consultation) }
end

def self.find(id)
  sql = "SELECT * FROM consultations
  WHERE id = $1"
  values = [id]
  result = SqlRunner.run(sql, values).first
  consultation = Consultation.new(result)
  return consultation
end

end
