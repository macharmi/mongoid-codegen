class Entity

    def initialize doc
        @doc = doc
    end

    def name
        return @doc['name']
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
        code = "{{message}}\n"
        code += "<form ng-submit='action(#{@doc['name'].downcase})' ng-show='!message'>\n"
        @doc['fields'].each{ |field|
            if field['name'] == 'id' then
                 code += "\t<span ng-show=\"location.indexOf('/#{@doc['name'].downcase}/edit') < 0 \">\n\t"
            end
             code = code + "\t#{field['name'].capitalize}:<br/><input ng-model='#{@doc['name'].downcase}.#{field['name']}' name='#{field['name']}' type='text'/><br/>\n"
 
            if field['name'] == 'id' then
                code += "\t</span>\n"
            end
         }
        code = code + "<input type='submit' value='Submit'/>\n"
        code = code + "</form>"
        return code
    end    
    
    def create_list
        code = "<h3>#{@doc['name'].downcase.capitalize} list</h3>\n"
        code += "{{message}}\n"
        code += "<div class='table-responsive'>\n"
        code += "\t<table class='table'>\n"
        code += "\t\t<thead>\n"
        code += "\t\t\t<tr>\n"
        @doc['fields'].each{ |field|
            code += "\t\t\t\t<th>#{field['name'].capitalize}</th>\n"
        }
        code += "\t\t\t\t<th><span class='fa fa-pencil fa-lg'></span></th>\n"
        code += "\t\t\t\t<th><span class='fa fa-scissors fa-lg'></th>\n"
        code += "\t\t\t</tr>\n"
        code += "\t\t</thead>\n"
        code += "\t\t<tbody>\n"
        code += "\t\t\t<tr ng-repeat='#{@doc['name'].downcase} in #{@doc['name'].downcase}s'>\n"
        @doc['fields'].each{ |field|
            code += "\t\t\t\t<td>#{@doc['name'].downcase}.#{field['name']}</td>\n"
        }
        code += "\t\t\t\t<td><a  class='fa fa-pencil fa-lg' href='/#/#{@doc['name'].downcase}/edit/{{#{@doc['name'].downcase}.id.$oid}}'></a></td>\n"
        code += "\t\t\t\t<td><a class='fa fa-scissors fa-lg' href='/#/#{@doc['name'].downcase}/delete/{{#{@doc['name'].downcase}.id.$oid}}'></a></td>\n"
        code += "\t\t\t</tr>\n"        
        code += "\t\t</tbody>\n"
        code += "\t</table>\n"
        code += "</div>\n"
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
