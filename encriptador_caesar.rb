require_relative 'caracter_no_valido_error'

class EncriptadorCaesar
	attr_reader :tipo_encriptacion
	
	# Por defecto la cantidad de lugares corridos es 3
	def initialize(lugares = 3, abecedario = ('A'..'Z').to_a.join)
		i = lugares % abecedario.size 
		@desencriptado = abecedario
		@encriptado = abecedario[i..-1] + abecedario[0...i]
		@tipo_encriptacion = "Caesar's Cypher"
	end
	
	# Encripta la clave enviada. Debe ser alfabética. Convierte la cadena
	# enviada a mayúsculas
	def encriptar(clave)
		if cadena_valida? clave
			clave.upcase.tr(@desencriptado, @encriptado)
		else
			raise CaracterNoValidoError.new clave
		end
	end
	
	# Desencripta la clave enviada. Debe ser alfabética. Convierte la cadena
	# enviada a mayúsculas
	def desencriptar(clave)
		if cadena_valida? clave
			clave.upcase.tr(@encriptado, @desencriptado)
		else
			raise CaracterNoValidoError.new clave
		end
	end
	
	# Valida que la clave sean sólo letras A - Z
	def cadena_valida?(cadena)
		cadena.match(/[A-Za-z]/) { |m| m != nil }
	end
	
	# Valida que una cadena enviada y una clave encriptada sean iguales
	# cuando la clave se desencripta. Convierte la cadena
	# enviada a mayúsculas
	def validar_clave(cadena, clave)
		(desencriptar clave).eql? cadena.upcase
	end
	

end
