require_relative("../db/sql_runner")
require_relative("./owner")

class Animal

  attr_reader(:id, :name, :age, :species, :admission_date, :is_adoptable)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @age = options['age']
    @species = options['species']
    @admission_date = options['admission_date']
    @is_adoptable = options['is_adoptable']
  end

  def save()
    sql = "INSERT INTO animals
    (
      name,
      age,
      species,
      admission_date,
      is_adoptable
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING id"
    values = [@name, @age, @species, @admission_date, @is_adoptable]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def owner()
    sql = "SELECT owners.* FROM adoptions
    INNER JOIN owners
    ON owners.id = adoptions.owner_id
    WHERE adoptions.animal_id = $1"
    values = [@id]
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
    ) =
    (
      $1, $2, $3, $4, $5
    )
    WHERE id = $6"
    values = [@name, @age, @species, @admission_date, @is_adoptable, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM
    animals
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM animals"
    results = SqlRunner.run( sql )
    return results.map { |animal| Animal.new( animal )  }
  end


  def self.available_animals()
    sql = "SELECT * FROM animals"
    results = SqlRunner.run(sql)
    return results.map { |adoption| Adoption.new( adoption ) if adoption.is_adoptable == true }
  end

  def self.available()
    sql = "SELECT * FROM animals WHERE id NOT IN (SELECT animal_id FROM adoptions) AND is_adoptable = $1"
    values = [true]
    results = SqlRunner.run(sql, values)
    return results.map { |animal| Animal.new( animal ) }
  end

  def self.find( id )
    sql = "SELECT * FROM animals
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Animal.new( results.first )
  end

  def self.delete( id )
    sql = "DELETE FROM
    animals
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM animals"
    SqlRunner.run( sql )
  end

end
