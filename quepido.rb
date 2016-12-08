require 'sinatra'
#require 'json'

comidas = ["pizza", "sushi", "milanesa", "hamburguesa", "empanadas", "pollo", "picada", "parrilla", "pastas", "ensalada", "sandwitch"]
etnicas = ["comida china", "comida armenia", "comida peruana", "comida india", "comida mexicana"]
todas = comidas + etnicas

not_found do
  status 404
  "This page could not be found"
end

get '/' do
  #send_file 'index.html'
  redirect to('/que')		# For now
end

get '/que' do
  dame_elemento_random_de comidas
end

get '/etnicas' do
  dame_elemento_random_de etnicas
end

get '/mas' do
  dame_elemento_random_de todas
end

get '/todas' do
  todas
end

def dame_elemento_random_de(lista)
  maxIndex = Random.rand(lista.size - 1)
  lista[maxIndex]
end
