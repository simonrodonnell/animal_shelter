require_relative("../models/owner")
require_relative("../models/animal")
require_relative("../models/adoption")
require("pry")

#delete_all
Adoption.delete_all()
Animal.delete_all()
Owner.delete_all()

#create owners
owner1 = Owner.new({
  "first_name" => "Andrew",
  "last_name" => "Ridgley",
  "age" => 25,
  "address" => "106, Hounslow Rd"
  })
owner2 = Owner.new({
  "first_name" => "Simon",
  "last_name" => "LeBon",
  "age" => 28,
  "address" => "52, Hull Road"
  })
owner3 = Owner.new({
  "first_name" => "Rick",
  "last_name" => "Astley",
  "age" => 21,
  "address" => "120, Thornton St"
  })
owner4 = Owner.new({
  "first_name" => "Boy",
  "last_name" => "George",
  "age" => 23,
  "address" => "51, Well Lane"
  })
owner1.save()
owner2.save()
owner3.save()
owner4.save()

#create animals
animal1 = Animal.new({
  "name" => "Frank",
  "age" => 3,
  "species" => "Cat",
  "admission_date" => "24/05/19",
  "is_adoptable" => true
  })
animal2 = Animal.new({
  "name" => "Alice",
  "age" => 5,
  "species" => "Dog",
  "admission_date" => "13/09/18",
  "is_adoptable" => true
  })
animal3 = Animal.new({
  "name" => "Rita",
  "age" => 1,
  "species" => "Parrot",
  "admission_date" => "16/05/17",
  "is_adoptable" => true
  })
animal4 = Animal.new({
  "name" => "Hans",
  "age" => 2,
  "species" => "Rabbit",
  "admission_date" => "19/06/19",
  "is_adoptable" => false
  })

animal1.save()
animal2.save()
animal3.save()
animal4.save()

#create adoptions (join table)

adoption1 = Adoption.new({
  "owner_id" => owner1.id,
  "animal_id" => animal1.id
  })
adoption1.save()

adoption2 = Adoption.new({
  "owner_id" => owner2.id,
  "animal_id" => animal2.id
  })
adoption2.save()


binding.pry
nil
