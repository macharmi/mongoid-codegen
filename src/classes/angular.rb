ANGULAR_EDIT = "
    	$scope.((Entity))Edit = function(((entity))){
		AppService.post('/((entity))/edit', $.param(((entity))))
		.then(
			function(res){
				$location.path('/((entity))/get/' + ((entity)).id.$oid);
			},
			function(err){
				alert(err);
			}
		)
	}
"


ANGULAR_ADD = "
	$scope.((Entity))Add = function(((entity))){
		AppService.post('/((entity))/add', $.param(((entity))))
		.then(
			function(res){
				$location.path('/((entity))/get/' + res.id.$oid);
			},
			function(err){
				$scope.message = err
			}
		)
	}
"

ANGULAR_INDEX = "
	$scope.Get = function(((entity))){
		AppService.get('/((entity))/index')
		.then(
			function(res){
				return res;
			},
			function(err){
				return(err);
			}
		)
"


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
    
    def self.addEntity(path, entity)
        code = ANGULAR_ADD
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end

    def self.indexEntity(path, entity)
        code = ANGULAR_INDEX
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end    

    def self.editEntity(path, entity)
        code = ANGULAR_EDIT
        code = code.gsub("((entity))",entity.name.downcase)
        code = code.gsub("((Entity))",entity.name.downcase)
        self.injectControllerCode(path,entity,code)
    end
end

