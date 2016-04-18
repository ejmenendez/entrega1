require_relative 'encriptador'

# Encripta y valida las claves de usuarios utilizando Caesar's Cypher<br>
# Desplaza 3 posiciones hacia adelante en el abecedario a cada letra de la cadena que 
# se quiere encriptar<br>
# Puede desencriptar una cadena enviada desplazándola 3 posiciones hacia atrás en el abecedario<br>
# Recibe cadenas que contengan sólo letras, se convierten a mayúsculas<br>
class EncriptadorCaesar < Encriptador
		
	# Asigna el tipo de encriptción en String, la regular expression y el mensaje de error
	# para la clave.<br>
	# La cantidad de lugares a despplazar es 3<br>
	# Crea un array con caracteres que conforman el abecedario a utilizar, de la A a la Z<br>
	# Crea dos arrays, uno encriptado y el otro no, para después hacer el reemplazo en 
	# la cadena que se quiere encriptar o desencriptar<br>
	def initialize
		# Defino los caracteres que pueden usarse en la clave y el mensaje de error
		super "Caesar's Cypher", /\A[A-Za-z]{4,}\z/, "La clave debe contener sólo caracteres de la A a la Z y debe tener al menos 4 caracteres""La clave debe contener sólo caracteres de la A a la Z y debe tener al menos 4 caracteres"

		lugares = 3
		abecedario = ('A'..'Z').to_a.join
		i = lugares % abecedario.size 
		@desencriptado = abecedario
		@encriptado = abecedario[i..-1] + abecedario[0...i]
	end
	
	# Encripta la clave enviada. Debe ser alfabética. <br>
	# Convierte la cadena enviada a mayúsculas
	def encriptar(clave)
		cadena_valida? clave
		clave.upcase.tr(@desencriptado, @encriptado)
	end
	
	# Desencripta la clave enviada. Debe ser alfabética. <br>
	# Convierte la cadena enviada a mayúsculas<br>
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def desencriptar(clave)
		cadena_valida? clave
		clave.upcase.tr(@encriptado, @desencriptado)
	end
	
	# Valida que una cadena enviada y una clave encriptada sean iguales
	# cuando la clave se desencripta. <br>
	# Convierte la cadena que se quiere comparar con la clave a mayúsculas<br>
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def clave_valida?(cadena, clave)
		cadena_valida? cadena
		(desencriptar clave).eql? cadena.upcase
	end
	

end
