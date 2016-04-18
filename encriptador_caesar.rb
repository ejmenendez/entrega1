require_relative 'caracter_no_valido_error'

# Encripta y valida las claves de usuarios utilizando Caesar's Cypher
# Los lugares a desplazar son configurables al momento de instanciar, 
# por defecto es 3.
class EncriptadorCaesar
		
	# El nombre del encriptador en formato String
	attr_reader :tipo_encriptacion
	# Regular expression que se necesita para validar la clave cuando es ingresada por el 
	# usuario en la vista
	attr_reader :regexp_clave
	# Mensaje de error para ser mostrado si el usuario ingresa una cadena que no cumple con
	# la regular expression asignada
	attr_reader :msj_error_clave
	
	# Asigna el tipo de encriptción en String, la regular expression y el mensaje de error
	# para la clave.
	# Por defecto la cantidad de lugares desplazados es 3
	# Puede recibir un array con caracteres que conforman el abecedario a utilizar, por defecto
	# es A...Z
	# Crea dos arrays, uno encriptado y el otro no, para después hacer el reemplazo en 
	# la cadena que se quiere encriptar o desencriptar
	def initialize(lugares = 3, abecedario = ('A'..'Z').to_a.join)
		# Defino los caracteres que pueden usarse en la clave y el mensaje de error
		@regexp_clave = /\A[A-Za-z]{4,}\z/
		@msj_error_clave = "La clave debe contener sólo caracteres de la A a la Z y debe tener al menos 4 caracteres"
		
		i = lugares % abecedario.size 
		@desencriptado = abecedario
		@encriptado = abecedario[i..-1] + abecedario[0...i]
		
		@tipo_encriptacion = "Caesar's Cypher"
	end
	
	# Encripta la clave enviada. Debe ser alfabética. 
	# Convierte la cadena enviada a mayúsculas
	def encriptar(clave)
		if cadena_valida? clave
			clave.upcase.tr(@desencriptado, @encriptado)
		else
			raise CaracterNoValidoError.new 
		end
	end
	
	# Desencripta la clave enviada. Debe ser alfabética. 
	# Convierte la cadena enviada a mayúsculas
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def desencriptar(clave)
		if cadena_valida? clave
			clave.upcase.tr(@encriptado, @desencriptado)
		else
			raise CaracterNoValidoError.new 
		end
	end
	
	# Valida que la clave sean sólo letras A - Z
	# Con un largo mínimo de 4 caracteres
	def cadena_valida?(cadena)
		cadena.match(@regexp_clave) { |m| m != nil }
	end
	
	# Valida que una cadena enviada y una clave encriptada sean iguales
	# cuando la clave se desencripta. 
	# Convierte la cadena que se quiere comparar con la clave a mayúsculas
	# Si la cadena enviada no es válida, levanta  CaracterNoValidoError
	def clave_valida?(cadena, clave)
		(desencriptar clave).eql? cadena.upcase
	end
	

end
