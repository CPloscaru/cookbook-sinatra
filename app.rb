require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"

get "/" do # <- Router part
  "Hello world!"

  # [...]   #
  # [...]   # <- Controller part
  # [...]   #
end
