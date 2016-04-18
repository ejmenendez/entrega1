require_relative 'encriptador'

# No implementa encriptación, las claves son guardadas tal como son enviadas.<br>
# Valida una cadena enviada comparándola con una clave almacenada
class EncriptadorTextoPlano < Encriptador
	
	# Asigna el tipo de encriptción en String, la regular expression y el mensaje de error
	# para la clave
	def initialize
		super 'Texto Plano', /\A[A-Za-z0-9_\-\.]{4,}\z/, "La clave debe tener al menos 4 caracteres. \nLos caracteres permitidos son: letras, números, _, - y ."
	end
	
	# Como es texto plano, se devuelve la misma cadena enviada<br>
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def encriptar(clave)
		cadena_valida? clave
		clave
	end
	
	# Valida que uns cadena enviada y una clave  sean iguales<br>
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def clave_valida?(cadena, clave)
		cadena_valida? cadena
		clave.eql? cadena
	end
	
end
