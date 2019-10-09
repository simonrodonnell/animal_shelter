require_relative("../models/animal")
require_relative("../models/owner")
require_relative("../models/adoption")
require_relative("../models/animal_type")

#index
# get "/animal-types" do
#   @animal_types = AnimalType.all()
#   erb( :"animal_types/index" )
# end

get '/animal-types/new' do
  erb(:"animal_types/new")
end

post '/animal-types' do
  new_animal_type = AnimalType.new({"species" => params['species'].downcase.capitalize})
  new_animal_type.save()
  redirect to "/animals"
end
