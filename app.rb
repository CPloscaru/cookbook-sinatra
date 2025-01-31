require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require_relative "cookbook"
require_relative "recipe"

get "/" do # <- Router part
  # [...]   #
  # [...]   # <- Controller part
  # [...]   #
  @cookbook = Cookbook.new("recipes.csv")
  @recipies = @cookbook.all
  erb :index
end

get "/new" do
  erb :new
end


post "/new" do
  #binding.pry
  @cookbook = Cookbook.new("recipes.csv")
  recipe = Recipe.new(params["n"], params["d"], params["r"], params["p"])
  @cookbook.create(recipe)
  @recipies = @cookbook.all
  redirect to('/')
end

get "/destroy/:id" do
  #binding.pry
  cookbook = Cookbook.new("recipes.csv")
  recipies = cookbook.all
  index = params[:id].to_i
  cookbook.destroy(index)
  redirect to('/')
end
