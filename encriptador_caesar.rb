
class EncriptadorCaesar
	attr_reader :tipo_encriptacion
	
	# Por defecto la cantidad de lugares corridos es 3
	def initialize(lugares = 3, abecedario = ('A'..'Z').to_a.join)
		i = lugares % abecedario.size 
		@desencriptado = abecedario
		@encriptado = abecedario[i..-1] + abecedario[0...i]
		@tipo_encriptacion = "Caesar's Cypher"
	end
	
	# Antes de reemplazar los caracteres, convierte la clave a mayúsculas
	def encriptar(clave)
		clave.upcase
		clave.tr(@desencriptado, @encriptado)
	end
	
	# Esta opción debería ser de uso privado - ver
	def desencriptar(string)
		string.upcase
		string.tr(@encriptado, @desencriptado)
	end
end
