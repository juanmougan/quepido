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
    if !params[:except].nil? && !params[:except].empty?
      temp_black_list = params[:except].split ","
    end
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
    send_file 'public/404.html'
  end

  def bad_request(message)
    status 400
    body message
  end

  get '/' do
    send_file 'public/index.html'
  end

  get '/que/clasicas' do
    begin
      randomizer.random_classic_except temp_black_list
    rescue ArgumentError
      bad_request 'Que lástima! No tenemos más sugerencias para la categoría "Clásicas"'
    ensure
      temp_black_list = []
    end
  end

  get '/que/etnicas' do
    begin
      randomizer.random_ethnics_except temp_black_list
    rescue ArgumentError
      bad_request 'Que lástima! No tenemos más sugerencias para la categoría "Étnicas"'
    ensure
      temp_black_list = []
    end
  end

  get '/que/todas' do
    begin
      randomizer.random_all_except temp_black_list
    rescue ArgumentError
      bad_request 'Que lástima! No tenemos más sugerencias para darte'
    ensure
      temp_black_list = []
    end
  end

  get '/que' do
    todas.to_json
  end

  run!
end
