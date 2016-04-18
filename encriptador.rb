require_relative 'caracter_no_valido_error'

# Superclase para los encriptadores.<br>
# Solamente implementa el método opara validar cadenas, los demás se deben implementar
# en las subclases.
class Encriptador

	# El nombre del encriptador en formato String
	attr_reader :tipo_encriptacion
	# Regular expression que se necesita para validar la clave cuando es ingresada por el 
	# usuario en la vista
	attr_reader :regexp_clave
	# Mensaje de error para ser mostrado si el usuario ingresa una cadena que no cumple con
	# la regular expression asignada
	attr_reader :msj_error_clave

	# Asigna el tipo de encriptación en String, la regular expression y el mensaje de error
	# para la clave
	def initialize(tipo_encriptacion, regexp_clave, msj_error_clave)
		@tipo_encriptacion = tipo_encriptacion
		@regexp_clave = regexp_clave
		@msj_error_clave = msj_error_clave
	end
	
	# Valida que una cadena enviada por parámetro cumpla con la regular expression 
	# asignada a la instancia del encriptador.
	# Si no cumple, levanta un CaracterNoValidoError 
	def cadena_valida?(cadena)
		valida = cadena.match(@regexp_clave) { |m| m != nil }
		if valida
			true
		else
			raise CaracterNoValidoError.new 
		end
	end
	
	# Para encriptar una clave, se debe implementar en las subclases.
	def encriptar(clave)
		raise NotImplementedError("Encriptador.encriptar(clave) se debe implementar en las sublcases")
	end
	
	# Verifica la validez de una cadena con una clave ya encriptada, se debe implementar en las subclases.
	def clave_valida?(cadena, clave)
		raise NotImplementedError("Encriptador.clave_valida?(cadena, clave) se debe implementar en las sublcases")
	end

end
