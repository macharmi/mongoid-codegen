class Angular
	def self.addRoute(file, route, controller, template)
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
end

