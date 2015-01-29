require 'rubygems'
require 'sinatra'
require 'erb'
require 'sinatra/partial'
require 'mongoid'
Mongoid.load!('config/db.yml',:development)

set :partial_template_engine, :erb
set :port, 80
#<<include_controllers>>

#<<include_models>>

# cope with css relative paths
get %r{.*/css/style.css} do
    redirect('css/style.css')
end

get '/views/*/*' do |path,filename|
	send_file 'views/' + path + "/" + filename
end

    
get "/" do
  erb 'layout/index'.to_sym,  :locals => {:title => "Mongoid-Codegen Project", :content => "This is page content"} 
end
# 404 Error!
not_found do
  status 404
  "404 - Page not found"
end