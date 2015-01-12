require 'json'
require_relative 'functions'

# check program arguments
unless ARGV.length >= 1
  puts "Error: this program requires the path of a json file as argument"
  exit
end

# create folder structures
ARGV[1].to_s == "" ? location= "./" : location = ARGV[1] + '/'
!Dir.exists?(location + "models") ? Dir.mkdir(location + "models") : nil
!Dir.exists?(location + "views") ? Dir.mkdir(location + "views") : nil
!Dir.exists?(location + "views/layout") ? Dir.mkdir(location + "views/layout") : nil
!Dir.exists?(location + "config") ? Dir.mkdir(location + "config") : nil
!Dir.exists?(location + "public") ? Dir.mkdir(location + "public") : nil
!Dir.exists?(location + "public/css") ? Dir.mkdir(location + "public/css") : nil
!Dir.exists?(location + "public/js") ? Dir.mkdir(location + "public/js") : nil

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
}

