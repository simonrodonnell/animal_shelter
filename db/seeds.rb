require_relative("../models/owner.rb")
require_relative("../models/animal.rb")
require("pry")

#delete_all
Animal.delete_all()
Owner.delete_all()

#create owners (one)
owner0 = Owner.new({
  "first_name" => "Animal",
  "last_name" => "Unassigned"
  })
owner1 = Owner.new({
  "first_name" => "Andrew",
  "last_name" => "Ridgley"
  })
owner2 = Owner.new({
  "first_name" => "Simon",
  "last_name" => "LeBon"
  })
owner0.save()
owner1.save()
owner2.save()

#create animals (many)
animal1 = Animal.new({
  "name" => "Frank",
  "age" => 3,
  "species" => "Cat",
  "admission_date" => "24/05/19",
  "is_adoptable" => true,
  "owner_id" => owner1.id
  })
animal2 = Animal.new({
  "name" => "Alice",
  "age" => 5,
  "species" => "Dog",
  "admission_date" => "13/09/18",
  "is_adoptable" => false,
  "owner_id" => owner0.id
  })

animal1.save()
animal2.save()

binding.pry
nil
