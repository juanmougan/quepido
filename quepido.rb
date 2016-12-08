require 'sinatra'
#require 'json'

comidas = ["pizza", "sushi", "milanesa", "hamburguesa", "empanadas", "pollo", "picada", "parrilla"]
etnicas = ["comida china", "comida armenia", "comida peruana", "comida india"]

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
  lista = comidas + etnicas
  dame_elemento_random_de lista
end

def dame_elemento_random_de(lista)
  maxIndex = Random.rand(lista.size - 1)
  lista[maxIndex]
end
