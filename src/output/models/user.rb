require 'mongoid'
class User
	include Mongoid::Document
	field :id,type Integer
	field :forename,type String
	field :lastname,type String
	field :mail
	field :birthdate
	field :gender
end