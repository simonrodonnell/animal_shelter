require_relative("../models/owner.rb")
require_relative("../models/animal.rb")

require("pry")

#delete_all
Animal.delete_all()
Owner.delete_all()

#create owners (one)
owner1 = Owner.new({
  "first_name" => "",
  "last_name" => ""
  })
owner2 = Owner.new({
  "first_name" => "",
  "last_name" => ""
  })
owner1.save()
owner2.save()

#create animals (many)
animal1 = Animal.new({
  "id" => "",
  "name" => "",
  "age" => "",
  "species" => "",
  "admission_date" => "",
  "is_adoptable" => "",
  "owner_id" => ""
  })
animal2 = Animal.new({
  "id" => "",
  "name" => "",
  "age" => "",
  "species" => "",
  "admission_date" => "",
  "is_adoptable" => "",
  "owner_id" => ""
  })

animal1.save()
animal2.save()

binding.pry
nil
