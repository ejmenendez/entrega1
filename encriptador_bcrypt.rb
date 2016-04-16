require 'bcrypt'

# Encripta y valida las claves de usuarios utilizando BCrypt
class EncriptadorBCrypt
	
	# El nombre del encriptador en formato String
	attr_reader :tipo_encriptacion
	# Regular expression que se necesita para validar la clave cuando es ingresada por el 
	# usuario en la vista
	attr_reader :regexp_clave
	# Mensaje de error para ser mostrado si el usuario ingresa una cadena que no cumple con
	# la regular expression asignada
	attr_reader :msj_error_clave
	
	# Asigna el tipo de encriptción en String, la regular expression y el mensaje de error
	# para la clave
	def initialize()
		@tipo_encriptacion = "BCrypt"
		@regexp_clave = nil
		@msj_error_clave = nil
	end
	
	# Devuelve un hash de BCrypt nuevo, creado a partir de la cadena enviada
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
