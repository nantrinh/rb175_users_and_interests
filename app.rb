require 'yaml'
require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

before do
  @data = YAML.load_file('users.yaml')
  @names = @data.keys.map(&:to_s)
  @num_users = @data.keys.size
end

get '/' do
  erb :home
end

get '/user/:name' do
  name = params[:name]
  redirect '/' unless @names.include?(name)
  @title = name.capitalize
  @user = @data[name.to_sym]
  @other_names = @names.reject {|x| x == name}
  erb :user
end

helpers do
  def count_interests
    ctr = 0
    @data.each_value {|v| ctr += v[:interests].size}
    ctr
  end
end
