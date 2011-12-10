require 'rubygems'
require 'mongoid'

Mongoid.logger = nil 
Mongoid.load!("config/mongoid.yml")

Dir["lib/**/*.rb"].each do |file|
  if !file.include?("like_contender") && !file.include?("user_contender")
    require File.expand_path(file)
  end
end