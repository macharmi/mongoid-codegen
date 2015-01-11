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


# open file
begin
    file = File.read(ARGV[0]) 
rescue 
    puts "Error: cannot open input file"
    exit
end

# parse json file
begin
specs = JSON.parse(file)
rescue
    puts "Error: json file is invalid"
    exit
end

# browse json structure and generate classes code
specs['documents'].each{|doc|
    File.write(location + "models/" + doc['name'].downcase + '.rb', generate_class(doc))
}

