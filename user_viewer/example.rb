require 'sinatra'

get '/test/?:p1?/?:p2?' do
  "Hello #{params[:p1]}, #{params[:p2]}"
end