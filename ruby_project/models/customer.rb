class Customer

  attr_reader :id, :pet_id
  attr_accessor :name, :appointment

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @pet_id = options['pet_id'].to_i
    @appointment = options['appointment']
  end

  def save()
    sql = "INSERT INTO customers
    (name, pet_id, appointment)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@name, @pet_id, @appointment]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def pet()
    pet = Pet.find(@pet_id)
    return pet
  end

  def update
    sql = "UPDATE customers
    SET name, pet_id, appointment)
    =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @pet_id, @appointment]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers
          where id = $1"
          values = [@id]
          SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    customer = map_items(customer_data)
    return customer
  end

  def self.map_items(customer_data)
    return customer_data.map { |customer| Customer.new(customer) }
  end

  def self.find(id)
    sql = "SELECT * FROM customer
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    customer = Customer.new(result)
    return customer
  end

end
