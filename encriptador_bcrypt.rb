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
		@regexp_clave = /\A[A-Za-z0-9_\-\.]{4,}\z/
		@msj_error_clave = "La clave debe tener al menos 4 caracteres \nLos caracteres permitidos son: letras, números, _, - y ."
	end
	
	# Devuelve un hash de BCrypt nuevo, creado a partir de la cadena enviada
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def encriptar(clave)
		if cadena_valida? clave
			BCrypt::Password.create(clave)
		else
			raise CaracterNoValidoError.new 
		end
	end
	
	# Valida que la clave sean sólo letras, números, guiones y puntos
	# Con un largo mínimo de 4 caracteres
	def cadena_valida?(cadena)
		cadena.match(/^[A-Za-z0-9_\-\.]{4,}$/) { |m| m != nil }
	end

	# Valida que uns cadena enviado y una clave encriptada sean iguales
	# cuando la cadena se encripta
	def validar_clave(cadena, clave)
		# la clave recibida debería ser una instancia de bcrypt, por lo tanto 
		# no se valida
		clave == cadena
	end
end
