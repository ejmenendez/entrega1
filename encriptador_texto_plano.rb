# No implementa encriptación, las claves son guardadas tal como son enviadas.
# Valida una cadena enviada comparándola con una clave almacenada
class EncriptadorTextoPlano
	
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
	def initialize
		@tipo_encriptacion = 'Texto Plano'
		@regexp_clave = nil
		@msj_error_clave = nil
	end
	
	# Como es texto plano, se devuelve la misma cadena enviada
	def encriptar(clave)
		clave
	end
	
	# Valida que uns cadena enviada y una clave  sean iguales
	def validar_clave(cadena, clave)
		clave.eql? cadena
	end
	
end
