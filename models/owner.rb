require_relative("../db/sql_runner")

class Owner

  attr_reader(:id, :first_name, :last_name)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def pretty_name()
    return "#{first_name.capitalize} #{last_name.capitalize}"

  end

  def save()
    sql = "INSERT INTO owners
    (
      first_name,
      last_name
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def animals()
    sql = "SELECT animals.* FROM owners
    INNER JOIN animals
    ON owners.id = animals.owner_id
    WHERE animals.owner_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |owner| Animal.new (animal)  }
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

  def self.delete_all
    sql = "DELETE FROM owners"
    SqlRunner.run( sql )
  end

end
