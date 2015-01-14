class App  
    def initialize(json_path, output_path)  
        # Instance variables  
        @json_path = json_path  
        output_path.to_s == "" ? @output_path= "./" : @output_path = output_path + '/'
    end
    def create_folders 
        # create folder structures
        !Dir.exists?(@output_path + "models") ? Dir.mkdir(@output_path + "models") : nil
        !Dir.exists?(@output_path + "views") ? Dir.mkdir(@output_path + "views") : nil
        !Dir.exists?(@output_path + "views/layout") ? Dir.mkdir(@output_path + "views/layout") : nil
        !Dir.exists?(@output_path + "config") ? Dir.mkdir(@output_path + "config") : nil
        !Dir.exists?(@output_path + "public") ? Dir.mkdir(@output_path + "public") : nil
        !Dir.exists?(@output_path + "public/css") ? Dir.mkdir(@output_path + "public/css") : nil
        !Dir.exists?(@output_path + "public/js") ? Dir.mkdir(@output_path + "public/js") : nil
    end
end  




