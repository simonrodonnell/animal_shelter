require_relative("../db/sql_runner")

class Animal

  attr_reader(:id, :name, :age, :species, :admission_date, :is_adoptable, :owner_id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @age = options['age']
    @species = options['type']
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
    values = [@age, @species, @admission_date, @is_adoptable, @owner_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

end
