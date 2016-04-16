class EncriptadorTextoPlano
	
	attr_reader :tipo_encriptacion
	
	def initialize
		@tipo_encriptacion = 'Texto Plano'
	end
	
	def encriptar(clave)
		clave
	end
	
	# Valida que uns cadena enviado y una clave  sean iguales
	def validar_clave(cadena, clave)
		clave.eql? cadena
	end
	
end
