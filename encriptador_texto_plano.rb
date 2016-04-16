class EncriptadorTextoPlano
	
	attr_reader :tipo_encriptacion
	attr_reader :regexp_clave
	attr_reader :msj_error_clave
	
	def initialize
		@tipo_encriptacion = 'Texto Plano'
		@regexp_clave = nil
		@msj_error_clave = nil
	end
	
	def encriptar(clave)
		clave
	end
	
	# Valida que uns cadena enviado y una clave  sean iguales
	def validar_clave(cadena, clave)
		clave.eql? cadena
	end
	
end
