def generate_class doc
    code = "require 'mongoid'" + "\n"
    code = code + 'class ' + doc['name'].downcase.capitalize + "\n"
    code += "\tinclude Mongoid::Document\n"
    doc['fields'].each{ |field|
        code = code + "\tfield :" + field["name"] + "\n"
    }
    code += 'end'
    return code
end