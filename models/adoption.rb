require_relative("../db/sql_runner")
require_relative("./owner")
require_relative("./animal")

class Adoption

  attr_reader(:id)
  attr_accessor(:owner_id, :animal_id)

  def initialize( options )
    @id = options["id"].to_i if options["id"]
    @owner_id = options["owner_id"].to_i
    @animal_id = options["animal_id"].to_i
  end

  def save()
    sql = "INSERT INTO adoptions
    (
      owner_id,
      animal_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@owner_id, @animal_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()["id"].to_i
  end

  def animal()
    sql = "SELECT * FROM animals WHERE id = $1"
    values = [@animal_id]
    results = SqlRunner.run(sql, values)
    return Animal.new(results.first)
  end

  def owner()
    sql = "SELECT * FROM owners WHERE id = $1"
    values = [@owner_id]
    results = SqlRunner.run(sql, values)
    return Owner.new(results.first)
  end

  def self.all()
    sql = "SELECT * FROM adoptions"
    results = SqlRunner.run(sql)
    return results.map { |adoption| Adoption.new( adoption )  }
  end

  def self.delete_all()
    sql = "DELETE FROM adoptions"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM adoptions WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end
end
