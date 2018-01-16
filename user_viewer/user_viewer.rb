require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"


before do 
  @users = YAML.load_file('users.yaml')
end

get "/" do
  erb :home
end

get "/users/:user" do
  @user = params['user']
  erb :user
end