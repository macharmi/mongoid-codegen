class Angular
    def self.addRoute(file, route, template,controller)
		code =	"\t\t\t.when('#{route}', {\n"
		code +=	"\t\t\t\ttemplateUrl: '#{template}',\n"
		code +=	"\t\t\t\tcontroller: '#{controller}'\n"
		code +=	"\t\t\t})\n"

		data = File.read(file) 
		newdata = data.gsub("/* <<include_routes>> */", "/* <<include_routes>> */\n" + code) 
	    File.open(file, "w") do |f|
	        f.write(newdata)	
	    end
	end  


	def self.addController(file, application, name, dependencies)
		code = "\n\n /* #{name} */\n#{application}.controller('#{name}', function($scope"
		dependencies.each{|dependency| code += ", #{dependency}"}	
		code += ")\n{\n/*<<#{name} code>>*/\n});\n"
		data = File.read(file) 
	    File.open(file, "w") do |f|
	        f.write(data + code)	
	    end
	end 	

    def self.injectControllerCode(file, entity, code)
        marker = "/*<<#{entity.name.downcase.capitalize}Controller code>>*/"
		data = File.read(file)
        newdata = data.gsub(marker, marker + code)
        File.open(file, "w") do |f|
	        f.write(newdata)	
	    end
    end
    
    def self.addControllerCode(path, entity)
        code = File.read('js/controller.js');
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end
    
    def self.addEntity(path, entity)
        code = File.read('js/add.js');
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end

    def self.indexEntity(path, entity)
        code = File.read('js/index.js');
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end    

    def self.editEntity(path, entity)
        code = File.read('js/edit.js');
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end
end

