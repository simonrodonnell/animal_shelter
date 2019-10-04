# require("sinatra")
# require("sinatra/contrib/all")
require_relative("../models/owner")
require_relative("../models/animal")
also_reload("../models/*")

get "/owners" do
  "Hello World!"
  # @owners = Owner.all()
  # erb( :"owners/index" )
end
