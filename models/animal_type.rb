require_relative("../db/sql_runner")
require_relative("./animal")
require("pry")

class AnimalType

  attr_reader(:id, :species)

  def initialize( options )
    @id = options["id"].to_i if options["id"]
    @species = options["species"]
  end

  def save()
    sql = "INSERT INTO animal_types
    (species) VALUES ($1) RETURNING id"
    values = [@species]
    results = SqlRunner.run( sql, values )
    @id = results.first()["id"].to_i
  end

  def animals()
    sql = "SELECT * FROM animals WHERE animal_type_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return Animal.new(results.first)
  end

  def self.all()
    sql = "SELECT * FROM animal_types"
    results = SqlRunner.run(sql)
    return results.map { |animal_type| AnimalType.new( animal_type )  }
  end

  def self.find(id)
    sql = "SELECT * FROM animal_types WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return AnimalType.new(results.first)
  end

  def self.delete_all()
    sql = "DELETE FROM animal_types"
    SqlRunner.run( sql )
  end


  def self.delete(id)
    sql = "DELETE FROM animal_types WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
