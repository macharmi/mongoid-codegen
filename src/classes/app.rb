class App  
    def initialize(json_path, output_path)  
        # Instance variables  
        @json_path = json_path  
        output_path.to_s == "" ? @output_path= "./" : @output_path = output_path + '/'
    end
    
    
    # create folder structures 
    def create_folders 
        !Dir.exists?(@output_path + "models") ? Dir.mkdir(@output_path + "models") : nil
        !Dir.exists?(@output_path + "controllers") ? Dir.mkdir(@output_path + "controllers") : nil
        !Dir.exists?(@output_path + "views") ? Dir.mkdir(@output_path + "views") : nil
        !Dir.exists?(@output_path + "views/layout") ? Dir.mkdir(@output_path + "views/layout") : nil
        !Dir.exists?(@output_path + "config") ? Dir.mkdir(@output_path + "config") : nil
        !Dir.exists?(@output_path + "public") ? Dir.mkdir(@output_path + "public") : nil
        !Dir.exists?(@output_path + "public/css") ? Dir.mkdir(@output_path + "public/css") : nil
        !Dir.exists?(@output_path + "public/js") ? Dir.mkdir(@output_path + "public/js") : nil
    end
    
    def move_files
        FileUtils.cp("./ressources/index.erb", "#{@output_path}views/layout")
        FileUtils.cp("./ressources/nav.erb", "#{@output_path}views/layout")
        FileUtils.cp("./ressources/sidebar.erb", "#{@output_path}views/layout")
        FileUtils.cp("./ressources/footer.erb", "#{@output_path}views/layout")
        FileUtils.cp("./ressources/db.yml", "#{@output_path}config")
        FileUtils.cp("./ressources/style.css", "#{@output_path}/public/css")
        FileUtils.cp("./ressources/app.js", "#{@output_path}/public/js")
        FileUtils.cp("./ressources/app.rb", "#{@output_path}")
        FileUtils.cp("./ressources/Gemfile", "#{@output_path}")
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
            data = File.read(@output_path + 'app.rb') 
            newdata = ""
            entity = Entity.new(doc)
            File.write(@output_path + "models/" + doc['name'].downcase + '.rb', entity.generate_class)
            filtered_data = data.gsub("<<include_models>>", "<<include_models>>\n" + "load 'models/#{doc['name'].downcase }.rb'\n") 
            File.open(@output_path + 'app.rb', "w") do |f|
                f.write(filtered_data)
            end
        }
    end
    
    # create forms
    def create_html_views
        @specs['documents'].each{|doc|
            entity = Entity.new(doc)
            File.write(@output_path + "views/" + doc['name'].downcase + '/form.htm', entity.create_form)
            File.write(@output_path + "views/" + doc['name'].downcase + '/index.htm', entity.create_list)
        }
    end

    # create controllers
    def create_controllers
        data = File.read(@output_path + 'app.rb') 
        filtered_data = ""
        @specs['documents'].each{|doc|
            data = File.read(@output_path + 'app.rb') 
            filtered_data = ""
            entity = Entity.new(doc)
            File.write(@output_path + "controllers/" + doc['name'].downcase + '.rb', entity.generate_controllers)
            filtered_data = data.gsub("<<include_controllers>>", "<<include_controllers>>\n" + "load 'controllers/#{doc['name'].downcase }.rb'\n") 
            File.open(@output_path + 'app.rb', "w") do |f|
                f.write(filtered_data)
            end
        }
    end

    # create angular routes
    def create_angular_routes
        @specs['documents'].each{|doc|
            entity = Entity.new(doc)
            Angular.addRoute(@output_path + "public/js/app.js","/#{ doc['name'].downcase}/new",
                "views/#{ doc['name'].downcase}/form.htm", "#{ doc['name'].downcase.capitalize}Controller");
            Angular.addRoute(@output_path + "public/js/app.js","/#{ doc['name'].downcase}/edit",
                "views/#{ doc['name'].downcase}/form.htm", "#{ doc['name'].downcase.capitalize}Controller");
            Angular.addRoute(@output_path + "public/js/app.js","/#{ doc['name'].downcase}/get/:id",
                "views/#{ doc['name'].downcase}/#{doc['name'].downcase}.htm", "#{ doc['name'].downcase.capitalize}Controller");
            Angular.addRoute(@output_path + "public/js/app.js","/#{ doc['name'].downcase}/index",
                "views/#{ doc['name'].downcase}/index.htm", "#{ doc['name'].downcase.capitalize}Controller");
        }
    end

    # create angular controllers
    def create_angular_controllers
        @specs['documents'].each{|doc|
            Angular.addController(  @output_path + "public/js/app.js", 
                                    'myApp',
                                    "#{ doc['name'].downcase.capitalize}Controller",
                                    ['$routeParams', '$location', '$window', 'AppService'])
        }
    end

    # populate angular controllers
    def populate_angular_controllers
        @specs['documents'].each{|doc|
            entity = Entity.new(doc)
            Angular.populate_controller(@output_path + "public/js/app.js", entity)
        }
    end


    # create view folder
    def create_view_folder
        @specs['documents'].each{|doc|
            !Dir.exists?(@output_path + "views/" + doc['name'].downcase) ? Dir.mkdir(@output_path + "views/" + doc['name'].downcase) : nil
        }
    end
end