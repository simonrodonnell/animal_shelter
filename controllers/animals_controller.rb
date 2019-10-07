require_relative("../models/animal")
require_relative("../models/owner")
require_relative("../models/adoption")
also_reload("../models/*")
require("pry")

get "/animals" do
  @animals = Animal.all()
  erb( :"animals/index" )
end

#new
get "/animals/new" do
  erb(:"animals/new")
end


get "/animals/ready" do
  @animals = Animal.ready()
  erb( :"animals/index" )
end

get "/animals/not-ready" do
  @animals = Animal.not_ready()
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
  new_animal_id = params['id'].to_i
  new_adoption = Adoption.new({
    "animal_id" => new_animal_id,
    "owner_id" => new_owner_id
    })
  new_adoption.save()
  redirect to "/animals/#{params['id']}"
end

post '/animals/:id/delete' do
  Animal.delete(params[:id])
  redirect to("/animals")
end

post '/animals/:id/status' do
  @animal = Animal.find(params[:id])
  # binding.pry
  @animal.status()
  redirect to "/animals/#{params['id']}"
end

#new
post "/animals" do
  Animal.new(params).save
  redirect to '/animals'
end

#edit
