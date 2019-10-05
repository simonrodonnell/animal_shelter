require_relative("../db/sql_runner")
require_relative("./owner")

class Animal

  attr_reader(:id, :name, :age, :species, :admission_date, :is_adoptable)
  attr_accessor(:owner_id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @age = options['age']
    @species = options['species']
    @admission_date = options['admission_date']
    @is_adoptable = options['is_adoptable']
    @owner_id = options['owner_id'].to_i
  end

  def save()
    sql = "INSERT INTO animals
    (
      name,
      age,
      species,
      admission_date,
      is_adoptable,
      owner_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING id"
    values = [@name, @age, @species, @admission_date, @is_adoptable, @owner_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def owner()
    sql = "SELECT owners.* FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE owners.id = $1"
    values = [@owner_id]
    results = SqlRunner.run(sql, values)
    return results.map { |owner| Owner.new (owner)  }
  end

  def update()
    sql = "UPDATE animals
    SET
    (
      name,
      age,
      species,
      admission_date,
      is_adoptable,
      owner_id
    ) =
    (
      $1, $2, $3, $4, $5, $6
    )
    WHERE id = $7"
    values = [@name, @age, @species, @admission_date, @is_adoptable, @owner_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM animals"
    results = SqlRunner.run( sql )
    return results.map { |animal| Animal.new( animal )  }
  end

  def self.find( id )
    sql = "SELECT * FROM animals
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Animal.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM animals"
    SqlRunner.run( sql )
  end

end
