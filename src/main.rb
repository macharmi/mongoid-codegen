require 'json'
require_relative 'classes/app'
require_relative 'classes/entity'

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

    # create mongoid entity classes
    app.create_entities
    
    # create html views
    app.create_html_views
    
    # create view folder
    app.create_view_folder
end
