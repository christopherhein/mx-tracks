require 'sinatra'
require 'yaml'

set :bind, '0.0.0.0'

helpers do
  def create_hal_object(id, object)
    object.merge({
      id: id,
      "_links": {
        self: { href: "/tracks/#{id}" },
        laptimes: { href: "/laptimes/#{id}" }
      }
    })
  end
  def wrap_hal_collection(objects)
    {
      "_embedded": objects,
      "_links": {
        self: { href: "/tracks" }
      }
    }
  end
end

get '/tracks' do
  tracks = YAML.load_file('tracks.yml')
  objects = tracks['tracks'].map {|t| create_hal_object(*t) }
  wrap_hal_collection(objects).to_json
end

get '/tracks/:id' do
  tracks = YAML.load_file('tracks.yml')
  create_hal_object(params[:id].to_s, tracks['tracks'][params[:id].to_s]).to_json
end
