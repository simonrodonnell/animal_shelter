require_relative("../db/sql_runner")
require_relative("./owner")
require_relative("./animal_type")
require("pry")

class Animal

  attr_reader(:id, :name, :age, :animal_type_id, :admission_date, :is_adoptable, :photo)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @age = options['age']
    @animal_type_id = options['animal_type_id'].to_i
    @admission_date = options['admission_date']
    @is_adoptable = options['is_adoptable']
    @photo = options['photo']
  end

  def save()
    sql = "INSERT INTO animals
    (
      name,
      age,
      animal_type_id,
      admission_date,
      is_adoptable,
      photo
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING id"
    values = [@name, @age, @animal_type_id, @admission_date, @is_adoptable, @photo]
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
      animal_type_id,
      admission_date,
      is_adoptable,
      photo
    ) =
    (
      $1, $2, $3, $4, $5, $6
    )
    WHERE id = $7"
    values = [@name, @age, @animal_type_id, @admission_date, @is_adoptable, @photo, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM
    animals
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def species()
    sql = "SELECT * FROM animal_types WHERE id = $1"
    values = [@animal_type_id]
    results = SqlRunner.run(sql, values)
    return AnimalType.new(results.first).species
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

  def self.ready()
    sql = "SELECT * FROM animals WHERE is_adoptable = $1"
    values = [true]
    results = SqlRunner.run(sql, values)
    return results.map { |animal| Animal.new( animal ) }
  end

  def self.not_ready()
    sql = "SELECT * FROM animals WHERE is_adoptable = $1"
    values = [false]
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

  def self.find_all_by_species( species_id )
    sql = "SELECT * FROM animals
    WHERE animal_type_id = $1"
    values = [species_id]
    results = SqlRunner.run(sql, values)
    return results.map { |animal| Animal.new( animal ) }
  end

  def self.delete( id )
    sql = "DELETE FROM
    animals
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def status()
    if @is_adoptable == "t"
      sql = "UPDATE animals
      SET is_adoptable = false
      WHERE id = $1"
    elsif @is_adoptable == "f"
      sql = "UPDATE animals
      SET is_adoptable = true
      WHERE id = $1"
    end
    values = [@id]
    # binding.pry
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM animals"
    SqlRunner.run( sql )
  end

end
