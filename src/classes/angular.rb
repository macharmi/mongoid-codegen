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
end

