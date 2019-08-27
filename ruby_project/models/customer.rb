class Customer

  attr_reader :id
  attr_accessor :name, :appointment, :contact_details

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @appointment = options['appointment']
    @contact_details = options['contact_details']
  end

  def save()
    sql = "INSERT INTO customers
    (name, appointment, contact_details)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@name, @appointment, @contact_details]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def pet()
    pet = Pet.find(@pet_id)
    return pet
  end

  def update()
    sql = "UPDATE customers
    SET (name,
         appointment,
       contact_details)
    =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @appointment, @contact_details, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
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
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    customer = Customer.new(result)
    return customer
  end

end
