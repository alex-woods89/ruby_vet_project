require_relative('../db/sql_runner')
require('pry')


class Vet

attr_reader :id
attr_accessor :name

def initialise(options)
   @id = options['id']
   @name = options['name']
end

def save
  sql = "INSERT INTO vets(name)
VALUES ($1)"
  values = [@name]
  result = SqlRunner.run(sql, values)
  id = result.first["id"]
  @id = id.to_i
end

def self.find(id)
  sql = "SELECT * FROM vets
  WHERE id = $1"
  values = [id]
  result = SqlRunner.run(sql ,values).first
  vet = House.new(result)
  return vet
end

def self.all()
  sql = "SELECT * FROM vets"
  vet_data = SqlRunner.run(sql)
  vets = map_items(house_data)
  return vets
end

def self.map_items(vet_data)
  return vet_data.map { |vet| Vet.new(vet) }
end

end

binding.pry
nil
