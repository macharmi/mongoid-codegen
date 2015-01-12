# Convert generic types to Mongoid ones
def translate_type type 
    res = case type.downcase
        when "char","string" then "String"
        when "int","integer" then "Integer"
    end
end

# Generate a class with documents fields
def generate_class doc
    code = "require 'mongoid'" + "\n"
    code = code + 'class ' + doc['name'].downcase.capitalize + "\n"
    code += "\tinclude Mongoid::Document\n"
    doc['fields'].each{ |field|
        code = code + "\tfield :" + field["name"] + ( translate_type(field["type"]).to_s != "" ? ",type " + translate_type(field["type"]) : "")  + "\n"
    }
    code += 'end'
    return code
end
        
# Generate html form - view

def generate_form doc
    code = "<form>"
    doc['fields'].each{ |field|
        code = code + "\t#{field['name'].capitalize}:<input ng-model='#{field['name']}' name='#{field['name']}' type='text'/><br/>\n"
    }
    code = code + "<input type='submit' value='Submit'>\n"
    code = code + "<form>"
    return code
end