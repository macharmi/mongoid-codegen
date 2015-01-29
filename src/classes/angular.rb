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


	def self.populate_controller (file, entity)
		controller_name = "#{entity.name.downcase.capitalize}Controller"
		data = File.read(file)

		code = "\n\t$scope.#{entity.name.downcase.capitalize}Add = function(#{entity.name.downcase}){"
		code += "\n\t\tAppService.post('/#{entity.name.downcase}/new', $.param(#{entity.name.downcase}))"
		code += "\n\t\t.then("
		code += "\n\t\t\tfunction(res){"
		code += "\n\t\t\t\talert(res);"
		code += "\n\t\t\t},"
		code += "\n\t\t\tfunction(err){"
		code += "\n\t\t\t\talert(err);"
		code += "\n\t\t\t}"
		code += "\n\t\t)"
		code += "\n\t}"
		newdata = data.gsub("/*<<#{controller_name} code>>*/", "/*<<#{controller_name} code>>*/" + code)
	    File.open(file, "w") do |f|
	        f.write(newdata)	
	    end
	end
end

