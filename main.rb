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
			sleep 1
			elapse = limit - Time.now
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

get '/options' do
	erb :options
end 

# => ANIMAL OPTION

# get all animal images
get '/animals' do
	@animals = Animal.all
	erb :animals
end 

# submit selected image
post '/animals' do

end 



# => USER OPTION

# user input pet info
get '/user' do
	erb :user
end 

# user submit pet info
post '/user' do
	animal = Animal.new
	animal.name = params[:name]
	animal.species = params[:species]
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
	upload = Medium.new
	upload.image = params[:image]
	upload.save
	redirect to('/user')
end










