require "sinatra"
require "sinatra/reloader"

get "/:order?" do 
  @files = Dir.glob("public/*")
  @files.reverse! if params['order'] == 'reversed'
  @files.map! {|file| file.split('/')[1]}
  erb :home
end