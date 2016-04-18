require 'bcrypt'

# Encripta y valida las claves de usuarios utilizando BCrypt
require_relative 'encriptador'

class EncriptadorBCrypt < Encriptador
			
	# Asigna el tipo de encriptción en String, la regular expression y el mensaje de error
	# para la clave
	def initialize()
		super "BCrypt", /\A[A-Za-z0-9_\-\.]{4,}\z/, "La clave debe tener al menos 4 caracteres \nLos caracteres permitidos son: letras, números, _, - y ."
	end
	
	# Devuelve un hash de BCrypt nuevo, creado a partir de la cadena enviada<br>
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def encriptar(clave)
		cadena_valida? clave
		BCrypt::Password.create(clave)
	end
	
	# Valida que uns cadena enviado y una clave encriptada sean iguales
	# cuando la cadena se encripta
	def clave_valida?(cadena, clave)
		# la clave recibida debería ser una instancia de bcrypt, por lo tanto 
		# implementa la comparación con ==
		clave == cadena
	end
end
