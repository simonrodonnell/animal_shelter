require_relative("../db/sql_runner")
require_relative("./owner")
require_relative("./animal")

class Adoption

  attr_reader(:id)
  attr_accessor(:owner_id, :animal_id)

  def initialize( options )
    @id = options["id"].to_i if options["id"]
    @owner_id = options["owner_id"]
    @animal_id = options["animal_id"]
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

  def self.delete_all()
    sql = "DELETE FROM adoptions"
    SqlRunner.run( sql )
  end

end
