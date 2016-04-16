class Usuario
	attr_reader :usuario
	attr_reader :clave
	attr_reader	:esta_logueado
	
	def initialize(usuario_inicial, clave_inicial)
		@usuario = usuario_inicial
		@clave = clave_inicial
		@esta_logueado = false
	end
	
	# Devuelve true si el usuario y la clave enviados por parámetros son iguales a los de este objeto
	def control_ingreso(p_usuario, p_clave)
		@esta_logueado = (p_usuario.eql? @usuario) && (p_clave.eql? @clave)
	end
	# Cambia el estado del usuario a logueado
	def iniciar_sesion
		@esta_logueado = true
	end
	
	# Cambia el estado a no logueado
	def cerrar_sesion 
		@esta_logueado = false
	end

end
