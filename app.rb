require 'sinatra'
require 'haml'
require 'pry'
require "sinatra/reloader" if development?
require_relative 'lib/user.rb'
require_relative 'lib/twit.rb'


set :haml, format: :html5
enable(:sessions)

@@users ||= []
@@twits = []
@twits_to_print = []
#@users = [User.new("Sahu", "12345"), User.new("JRSC", "12345")]
#@twits = [Twit.new("Lorem Ipsum", "Sahu"), Twit.new("Ouyeahhh!", "Sahu")]

before '/profile' do
   unless session[:logged_in] 
    redirect to('/')
	end
end

before '/' do
   session[:logged_in] = false
end

def user_valid?(name, password)
	@@users.find {|user| user.name == name && user.password == password }
end

get '/' do
	unless session[:logged_in]
	 	@alert = "You are not logged in"
	end
  erb(:index)
end

post '/register' do
  if params[:username] == "" || params[:password] == ""
  	 @error = "Usuario o contraseña en blanco"
  	 session[:errors] = @error
  	 erb(:login)
  elsif @@users.find { |user| user.name == params[:username] }
  	@error = "You are registered yet, please click Log in"
   	session[:errors] = @error
  	erb(:login)
  else
  	@user = User.new(params[:username], params[:password])
  	@@users << @user
  	session[:logged_in] = true
  	redirect to('/profile')
  end
end

get '/login' do
	erb(:login)
end

post '/login' do
	if user_valid?(params[:username], params[:password])
		session[:username] = params[:username]
		session[:logged_in] = true
		redirect to('/profile')
	else
		redirect to('/')
	end
end

get '/profile' do
    @twits_to_print = @@twits.select { |twit| twit.username == session[:username]}
    erb(:profile)
end

get "/logout" do
  session[:logged_in] = false
  # session[:username] = ""
  # session[:password] = ""
  redirect to("/")
end

post '/crear_twit' do
  @@twits << Twit.new(params[:message], session[:username])
  redirect to("/profile")
end






