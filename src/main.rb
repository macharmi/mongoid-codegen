require 'json'
require 'fileutils'
require_relative 'classes/app'
require_relative 'classes/entity'
require_relative 'classes/angular'
# check program arguments
unless ARGV.length >= 1
  puts "Error: this program requires the path of a json file as argument"
  exit
end

ARGV[1].to_s == "" ? location= "./" : location = ARGV[1] + '/'

app = App.new(ARGV[0],location)

if app.load then

    # create folder structures
    app.create_folders
    app.move_files

    # create mongoid entity classes
    app.create_entities
    
    # create view folder
    app.create_view_folder
    
    # create html views
    app.create_html_views
    
    # create controllers
    app.create_controllers

    # create view routes
    app.create_angular_routes

    # create controllers
    app.create_angular_controllers    
end
