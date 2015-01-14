require 'rubygems'
require 'sinatra'
require 'erb'
require 'sinatra/partial'
require 'mongoid'
Mongoid.load!('config/db.yml',:development)

set :partial_template_engine, :erb
set :port, 80

#<<include_models>>
    
get "/" do
  erb 'layout/index'.to_sym,  :locals => {:title => "Mongoid-Codegen Project", :content => "This is page content"} 
end