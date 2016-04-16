require 'bcrypt'

class EncriptadorBCrypt
	attr_reader :tipo_encriptacion
	
	def initialize()
		
		@tipo_encriptacion = "BCrypt"
	end

	def encriptar(string)
		BCrypt::Password.create(string)
	end

	def desencriptar(string)
		
	end
end
