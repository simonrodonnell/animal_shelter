require_relative("../models/animal")
require_relative("../models/owner")
require_relative("../models/adoption")
also_reload("../models/*")

#index
get "/adoptions" do
  @adoptions = Adoption.all()
  erb( :"adoptions/index" )
end

get '/adoptions/assign' do
  @owners = Owner.all
  @animals = Animal.available
  erb(:"adoptions/assign")
end

post '/adoptions/assign' do
  new_owner_id = params['owner_id'].to_i
  new_animal_id = params['animal_id'].to_i
  new_adoption = Adoption.new({
    "animal_id" => new_animal_id,
    "owner_id" => new_owner_id
    })
  new_adoption.save()
  redirect to "/adoptions"
end

get '/adoptions/:id' do
  @adoption = Adoption.find(params['id'])
  erb(:"adoptions/show")
end

#delete
post '/adoptions/:id/delete' do
  Adoption.delete(params[:id])
  redirect to("/adoptions")
end
