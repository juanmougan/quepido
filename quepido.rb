require 'sinatra'
require 'json'
require "sinatra/config_file"
require "sinatra/cors"

config_file './config/comidas.yml'

clasicas = settings.clasicas
etnicas = settings.etnicas
todas = clasicas + etnicas

set :allow_origin, "http://localhost https://quepido.herokuapp.com"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

not_found do
  status 404
  "Esta p&aacute;gina no existe :("
end

get '/' do
  send_file 'public/index.html'
end

get '/que/clasicas' do
  dame_elemento_random_de clasicas
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
