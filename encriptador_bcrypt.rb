require 'bcrypt'

class EncriptadorBCrypt
	attr_reader :tipo_encriptacion
	attr_reader :regexp_clave
	attr_reader :msj_error_clave
	
	def initialize()
		@tipo_encriptacion = "BCrypt"
		@regexp_clave = nil
		@msj_error_clave = nil
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
