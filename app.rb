require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/animals_controller")
require_relative("controllers/owners_controller")
require_relative("controllers/adoptions_controller")
require_relative("controllers/animal_types_controller")
also_reload("../models/*")

get "/" do
  erb(:index)
end
