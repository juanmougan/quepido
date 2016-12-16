require 'sinatra'
require 'json'

comidas = ["pizza", "sushi", "milanesa", "hamburguesa", "empanadas", "pollo", "picada", "parrilla", "pastas", "ensalada", "sandwich"]
etnicas = ["comida china", "comida armenia", "comida peruana", "comida india", "comida mexicana"]
todas = comidas + etnicas

not_found do
  status 404
  "Esta p&aacute;gina no existe :("
end

get '/' do
  send_file 'public/index.html'
end

get '/que/clasicas' do
  dame_elemento_random_de comidas
end

get '/que/etnicas' do
  dame_elemento_random_de etnicas
end

get '/que/todas' do
  dame_elemento_random_de todas
end

get '/que' do
  todas.to_json
end

def dame_elemento_random_de(lista)
  maxIndex = Random.rand(lista.size - 1)
  lista[maxIndex]
end
