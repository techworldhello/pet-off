require 'sinatra'
require 'sinatra/reloader' 
require 'pry'

require_relative 'db_config'
require_relative 'models/animal'
require_relative 'models/like'
require_relative 'models/user'
require_relative 'models/medium'

enable :sessions

helpers do
	def logged_in?
		!!current_user 
	end 

	def current_user
		User.find_by(id: session[:loggedin_user_id])
	end 

	def calc_time seconds 
		limit = Time.now + seconds * 60
		while Time.now < limit
			elapse = limit - Time.now
			sleep 1
		end
	end 
end 

get '/' do
  erb :login
end

post '/session' do
	user = User.find_by(email: params[:email])
	if user && user.authenticate(params[:password])
		session[:loggedin_user_id] = user.id
		redirect to("/options")
	else
		erb :login
	end 
end 

get '/signup' do
	@user = User.new
	erb :signup
end 

post '/signup' do
	user = User.new
	user.email = params[:email]
	user.password = params[:password]
	user.save
	redirect '/'
end 

get '/options' do
	erb :options
end 

get '/about' do
	erb :about
end 

# get main acc page
get '/account' do
	erb :account
end

# get to page to edit
get '/account/:id/edit' do
	redirect to('/') unless logged_in?
 	@animal = Animal.find(params[:id])
	erb :edit
end 

# update edits
put '/account/:id' do
	redirect to('/') unless logged_in?
	animal = Animal.find(params[:id])
	animal.name = params[:name]
	animal.media[0].image = params[:image_url]
	animal.media[0].save
	animal.user_id = current_user.id
	animal.save
	redirect to ('/account')
end 

# delete image
delete '/account/:id/delete' do
	redirect to('/') unless logged_in?
	Animal.find(params[:id]).destroy
	redirect to('/account')
end 

# => ANIMAL OPTION

# get all animal images
get '/animals' do
	@animals = Animal.all.sample(2)
	@media = @animals.map do |animal|
			animal.media[0]
	end
	erb :animals
end 

post '/likes' do 
	redirect to('/') unless logged_in?
	like = Like.new
	like.animal_id = params[:animal_id]
	like.user_id = current_user.id
	like.save
	redirect to("/animals")
end 

# => USER OPTION

# user input pet info
get '/user' do
	erb :user
end 

# user submit pet info
post '/user' do
	redirect to('/') unless logged_in?
	animal = Animal.new
	animal.name = params[:name]
	animal.species = params[:species]
	animal.user_id = current_user.id
	animal.save
	redirect to("/user/media?animal_id=#{animal.id}")
end 

# user upload pet image
get '/user/media' do
	@animal_id = params[:animal_id]
	erb :media
end 

# user submit pet image
post '/user/media' do
	redirect to('/') unless logged_in?
	upload = Medium.new
	upload.image = params[:image]
	upload.animal_id = params[:animal_id]
	upload.save
	redirect to('/user/media/another')
end

get '/user/media/another' do
	@animal_id = params[:animal_id]
	erb :another_media
end 

post '/user/media/another' do
	redirect to('/') unless logged_in?
	upload = Medium.new
	upload.image = params[:image]
	upload.animal_id = params[:animal_id]
	upload.save
	redirect to('/user/media/another')
end




