require 'json'


# check program arguments
unless ARGV.length >= 1
  puts "Error: this program requires the path of a json file as argument"
  exit
end

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
    classname = doc['name']
    doc['fields'].each{ |field|
        puts field['name']
    }
}

