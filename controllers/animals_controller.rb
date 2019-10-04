# require("sinatra")
# require("sinatra/contrib/all")
require_relative("../models/animal")
require_relative("../models/owner")
also_reload("../models/*")

get "/animals" do
  @animals = Animal.all()
  erb( :"animals/index" )
end
