class App  
    def initialize(json_path, output_path)  
        # Instance variables  
        @json_path = json_path  
        output_path.to_s == "" ? @output_path= "./" : @output_path = output_path + '/'
    end
    
    
    # create folder structures 
    def create_folders 
        !Dir.exists?(@output_path + "models") ? Dir.mkdir(@output_path + "models") : nil
        !Dir.exists?(@output_path + "views") ? Dir.mkdir(@output_path + "views") : nil
        !Dir.exists?(@output_path + "views/layout") ? Dir.mkdir(@output_path + "views/layout") : nil
        !Dir.exists?(@output_path + "config") ? Dir.mkdir(@output_path + "config") : nil
        !Dir.exists?(@output_path + "public") ? Dir.mkdir(@output_path + "public") : nil
        !Dir.exists?(@output_path + "public/css") ? Dir.mkdir(@output_path + "public/css") : nil
        !Dir.exists?(@output_path + "public/js") ? Dir.mkdir(@output_path + "public/js") : nil
    end
    
    def move_files
        FileUtils.cp("./views/index.erb", "#{@output_path}views/layout")
        FileUtils.cp("./views/nav.erb", "#{@output_path}views/layout")
        FileUtils.cp("./views/sidebar.erb", "#{@output_path}views/layout")
        FileUtils.cp("./views/footer.erb", "#{@output_path}views/layout")
        FileUtils.cp("./config/db.yml", "#{@output_path}config")
    end
    
    # open specifications file and load it to a json structure
    def load 
        begin
            file = File.read(@json_path) 
        rescue 
            @ready = false
            puts "Error: cannot open input file"
        end
        begin
            @specs = JSON.parse(file)
            @ready = true
        rescue
            @ready = false
            puts "Error: JSON file is invalid"
        end
        return @ready
    end
    
    # create mongoid entity classes
    def create_entities
        @specs['documents'].each{|doc|
            entity = Entity.new(doc)
            File.write(@output_path + "models/" + doc['name'].downcase + '.rb', entity.generate_class)
        }
    end
    
    # create forms
    def create_html_views
        @specs['documents'].each{|doc|
            entity = Entity.new(doc)
            File.write(@output_path + "views/" + doc['name'].downcase + '/add.htm', entity.create_form)
        }
    end
    
    # create view folder
    def create_view_folder
        @specs['documents'].each{|doc|
            !Dir.exists?(@output_path + "views/" + doc['name'].downcase) ? Dir.mkdir(@output_path + "views/" + doc['name'].downcase) : nil
        }
    end
end  




