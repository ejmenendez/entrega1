require 'bcrypt'

class EncriptadorBCrypt
	attr_reader :tipo_encriptacion
	
	def initialize()
		@tipo_encriptacion = "BCrypt"
	end

	def encriptar(string)
		BCrypt::Password.create(string)
	end

	# Valida que uns cadena enviado y una clave encriptada sean iguales
	# cuando la cadena se encripta
	def validar_clave(cadena, clave)
		# la clave recibida debería ser una instancia de bcrypt
		clave == cadena
	end
end
