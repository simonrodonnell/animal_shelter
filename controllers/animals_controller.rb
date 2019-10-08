require_relative("../models/animal")
require_relative("../models/owner")
require_relative("../models/adoption")
require_relative("../models/animal_type")
also_reload("../models/*")
require("pry")

#index
get "/animals" do
  @animals = Animal.all()
  erb( :"animals/index" )
end

#new
get "/animals/new" do
  @animal_types = AnimalType.all()
  erb(:"animals/new")
end

#list ready for adoption
get "/animals/ready" do
  @animals = Animal.ready()
  erb( :"animals/index" )
end

#list not ready for adoption
get "/animals/not-ready" do
  @animals = Animal.not_ready()
  erb( :"animals/index" )
end

get "/animals/search" do
  @animal_types = AnimalType.all()
  erb(:"animals/search")
end

post "/animals/search/results" do
  @animals = Animal.find_all_by_species(params['animal_type_id'])
  # binding.pry
  erb( :"animals/index")
end

#show individual animal
get "/animals/:id" do
  @animal = Animal.find(params['id'])
  erb( :"animals/show" )
end

#assign animal to owner
get "/animals/:id/assign" do
  @owners = Owner.all
  @animal = Animal.find(params['id'])
  erb(:"animals/assign")
end

post "/animals/:id/assign" do
  new_adoption = Adoption.new({
    "animal_id" => params['id'].to_i,
    "owner_id" => params['owner_id'].to_i
    })
  new_adoption.save()
  redirect to "/animals/#{params['id']}"
end

# delete animal
  post '/animals/:id/delete' do
    Animal.delete(params[:id])
    redirect to("/animals")
  end

  # change healthy/not healthy status
  post '/animals/:id/status' do
    @animal = Animal.find(params[:id])
    @animal.status()
    redirect to "/animals/#{params['id']}"
  end

  #new
  post "/animals" do
    Animal.new(params).save
    redirect to '/animals'
  end

  #edit
