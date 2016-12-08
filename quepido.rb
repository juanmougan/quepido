require 'sinatra'
#require 'json'

comidas = ["pizza", "sushi", "milanesa", "hamburguesa", "empanadas", "pollo", "picada"]

not_found do
  status 404
  "This page could not be found"
end

get '/' do
  #send_file 'index.html'
  redirect to('/que')		# For now
end

get '/que' do
  maxIndex = Random.rand(comidas.size - 1)
  comidas[maxIndex]
end
