# require("sinatra")
# require("sinatra/contrib/all")
require("pry")
require_relative("../models/animal")
require_relative("../models/owner")
also_reload("../models/*")

get "/animals" do
  @animals = Animal.all()
  erb( :"animals/index" )
end

get "/animals/:id" do
  @animal = Animal.find(params['id'])
  erb( :"animals/show" )
end

get "/animals/:id/assign" do
  @owners = Owner.all
  @animal = Animal.find(params['id'])
  erb(:"animals/assign")
end

post "/animals/:id/assign" do
  new_owner_id = params['owner_id'].to_i
  animal = Animal.find(params['id'])
    # binding.pry
  animal.owner_id = new_owner_id
  animal.update
  redirect to "/animals/#{params['id']}"
end
