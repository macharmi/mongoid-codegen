require 'json'
require_relative 'functions'
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
    exit
end

# open file
begin
    file = File.read(ARGV[0]) 
rescue 
    puts "Error: cannot open input file"
    exit
end

# parse JSON file
begin
specs = JSON.parse(file)
rescue
    puts "Error: JSON file is invalid"
    exit
end

# browse json structure and generate classes code
specs['documents'].each{|doc|
    # create model class
    File.write(location + "models/" + doc['name'].downcase + '.rb', generate_class(doc))
    
    # create view folder
    !Dir.exists?(location + "views/" + doc['name'].downcase) ? Dir.mkdir(location + "views/" + doc['name'].downcase) : nil
    
    # create html views
    File.write(location + "views/" + doc['name'].downcase + '/form.htm', generate_form(doc))
    
    # create app.rb (main sinatra file)
    
}

