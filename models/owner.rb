require_relative("../db/sql_runner")
require_relative("./animal")

class Owner

  attr_reader(:id, :first_name, :last_name, :age, :address)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @age = options['age']
    @address = options['address']
  end

  def pretty_name()
    return "#{@first_name.capitalize} #{@last_name.capitalize}"
  end

  def save()
    sql = "INSERT INTO owners
    (
      first_name,
      last_name,
      age,
      address
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@first_name, @last_name, @age, @address]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def animal()
    sql = "SELECT animals.* FROM adoptions
    INNER JOIN animals
    ON animals.id = adoptions.animal_id
    WHERE adoptions.owner_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |animal| Animal.new (animal)  }
  end

  def delete()
    sql = "DELETE FROM owners
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE owners
    SET
    (
      first_name,
      last_name,
      age,
      address
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@first_name, @last_name, @age, @address, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM owners"
    results = SqlRunner.run( sql )
    return results.map { |owner| Owner.new ( owner ) }
  end

  def self.find( id )
    sql = "SELECT * FROM owners
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Owner.new( results.first )
  end

  def self.delete( id )
    sql = "DELETE FROM owners
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all
    sql = "DELETE FROM owners"
    SqlRunner.run( sql )
  end

end
