require "sinatra"
require "json"
require "sinatra/config_file"
require 'sinatra/cross_origin'
require './randomizer.rb'

class QuePido < Sinatra::Base
  register Sinatra::ConfigFile
  config_file './config/comidas.yml'

  clasicas = settings.clasicas
  etnicas = settings.etnicas
  todas = clasicas + etnicas
  randomizer = Randomizer.new(clasicas, etnicas)
  temp_black_list = []

  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  before '/que/*' do
    temp_black_list = params[:except] unless params[:except].nil?
    puts "temp_black_list: #{temp_black_list}"
  end

  after '/que/*' do
    temp_black_list = []
  end
  
  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  not_found do
    status 404
    "Esta p&aacute;gina no existe :("
  end

  get '/' do
    send_file 'public/index.html'
  end

  get '/que/clasicas' do
    randomizer.random_classic_except temp_black_list
  end

  get '/que/etnicas' do
    randomizer.random_ethnics_except temp_black_list
  end

  get '/que/todas' do
    randomizer.random_all_except temp_black_list
  end

  get '/que' do
    todas.to_json
  end

  run!
end
