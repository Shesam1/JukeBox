require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'sqlite3'
require './models'

enable :sessions
set :database, {adapter: 'sqlite3', database: 'microblog.sqlite3'}

CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/public"
end

before do
  current_user
end

# login protecting routes
before ['/buzzfeed','/profile','/newpost','/logout','/newpost'] do
  redirect '/' unless @current_user
end

get '/' do
	erb :home
end

get '/home' do
  redirect '/signup'
end

get '/buzzfeed' do
  @users = User.all
  @posts = Post.all
  erb :buzzfeed
end

get '/profile' do
	# @users = User.all
	erb :profile, locals: {user: @current_user}
end

get'/login' do
	erb :login
end

get '/signup' do 
	erb :signup
end

post '/signup' do
  p params
  user = User.new(
    name: params[:name],
    last: params[:last],
    username: params[:username],
    password: params[:password],
    photo: params[:photo],
    occupancy: params[:occupancy],
    relationship: params[:relationship]
  )
  # user.photo = params[:photo]
  if user.save
    flash[:message] = "Welcome! You've registered successfully"
    session[:user_id] = user.id
    redirect '/buzzfeed'
  else
    flash[:message] = "Ooops, something went wrong. Your account couldn't be created at this time"
    redirect back
  end
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    flash[:message] = "Welcome"
    redirect '/buzzfeed'
  else 
    flash[:message] = "Incorrect Username or Password"
    redirect back 
  end
end

post '/logout' do
  session[:user_id] = nil
  flash[:message] = "You've Logged Out Safely"
  redirect '/'
end

def current_user
  @current_user = User.find(session[:user_id]) if session[:user_id]
end

post '/newpost' do
  post = Post.new(
    photo: params[:photo],
    message: params[:message],
    user_id: @current_user.id
  )
  post.save
  redirect '/buzzfeed'
end

post '/comment' do
  comment = Comment.new(
    message: params[:message],
    user_id: @current_user.id,
    post_id: params[:post_id]
  )
  comment.save
  redirect back
end

post '/profile/update' do
    @current_user.update(
        username: params[:username],
        password: params[:password],
        occupancy: params[:occupancy],
        relationship: params[:relationship]
    ) 
    redirect back
end
















