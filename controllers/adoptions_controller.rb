# require("sinatra")
# require("sinatra/contrib/all")
require("pry")
require_relative("../models/animal")
require_relative("../models/owner")
require_relative("../models/adoption")
also_reload("../models/*")

#index
get "/adoptions" do
  # "Hello World!"
  @adoptions = Adoption.all()
  erb( :"adoptions/index" )
end

#delete
