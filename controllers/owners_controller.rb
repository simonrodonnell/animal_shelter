require_relative("../models/owner")
require_relative("../models/animal")
require_relative("../models/adoption")
also_reload("../models/*")

get "/owners" do
  @owners = Owner.all()
  erb( :"owners/index" )
end

#new
get "/owners/new" do
  erb(:"owners/new")
end

get "/owners/:id" do
  @owner = Owner.find(params['id'])
  erb( :"owners/show" )
end

get "/owners/:id/assign" do
  @animals = Animal.available() # what if nil?
  @owner = Owner.find(params['id'])
  erb(:"owners/assign")
end

post "/owners/:id/assign" do
  new_animal_id = params['animal_id'].to_i
  new_owner_id = params['id'].to_i
  new_adoption = Adoption.new({
    "animal_id" => new_animal_id,
    "owner_id" => new_owner_id
    })
  new_adoption.save()
  redirect to "/owners/#{params['id']}"
end


#new
post "/owners" do
  Owner.new(params).save
  redirect to '/owners'
end

#delete
post '/owners/:id/delete' do
  Owner.delete(params[:id])
  redirect to("/owners")
end

#edit
