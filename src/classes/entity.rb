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
            code = code + "\tfield :" + field["name"]+( translate_type(field["type"]).to_s != "" ? ",type " + translate_type(field["type"]) : "") + "\n"
        }
        code += 'end'
        return code
    end
    
    def create_form
        code = "<form>"
        @doc['fields'].each{ |field|
            code = code + "\t#{field['name'].capitalize}:<br/><input ng-model='#{field['name']}' name='#{field['name']}' type='text'/><br/>\n"
        }
        code = code + "<input type='submit' value='Submit'>\n"
        code = code + "<form>"
        return code
    end    
end
