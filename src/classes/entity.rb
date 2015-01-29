class Entity

    def initialize doc
        @doc = doc
    end

    # Generate a class with documents fields
    def generate_class
        code = "require 'mongoid'" + "\n"
        code = code + 'class ' + @doc['name'].downcase.capitalize + "\n"
        code += "\tinclude Mongoid::Document\n"
        @doc['fields'].each{ |field|
            code = code + "\tfield :" + field["name"]+( translate_type(field["type"]).to_s != "" ? ",type: " + translate_type(field["type"]) : "") + "\n"
        }
        code += 'end'
        return code
    end
    
    def create_form
        code = "<form ng-submit='#{@doc['name'].downcase.capitalize}Add(#{@doc['name'].downcase})'>\n"
        @doc['fields'].each{ |field|
            code = code + "\t#{field['name'].capitalize}:<br/><input ng-model='#{@doc['name'].downcase}.#{field['name']}' name='#{field['name']}' type='text'/><br/>\n"
        }
        code = code + "<input type='submit' value='Submit'>\n"
        code = code + "<form>"
        return code
    end    

    def translate_type type 
        res = case type.downcase
            when "char","string" then "String"
            when "int","integer" then "Integer"
        end
    end
            
    def generate_controllers 
        # Each entity should implement at least the following operations
        
        code = ""
        code = code + "get '/#{@doc['name'].downcase}/get/:id' do\n"
        code = code + "\tparams[:id]\n"
        code = code + "end\n\n"

        code = code + "post '/#{@doc['name'].downcase}/new' do \n"
        code = code + "\t" + @doc['name'].downcase.capitalize + '.create('
        @doc['fields'].each{ |field|
            code = code + "\t\t:" + field["name"] +" => params[:" + field["name"] + "]"
            if field != @doc['fields'].last
                code +=",\n"
            end
        }
        code += "\n\t)\n"
        code = code + "end\n\n"
        
        code += "get '/#{@doc['name'].downcase}/create' do\n"
        code += "\tcontent = File.read('views/#{@doc['name'].downcase}/add.htm' )\n" 
        code += "\terb 'layout/index'.to_sym,  :locals => {:title => 'New #{@doc['name'].downcase.capitalize}', :content => content}\n" 
        code = code + "end\n\n"
            
        
        return code
        
        
        
        
        # get /entity/get/:id
        # get /entity/index
        # get /entity/create
        # get /entity/update
        # post /entity/search
        # post /entity/update
        # post /entity/new
        # post /entity/delete        
        
    end
    
end
