# Representa un usuario del sistema, guardando su usuario, contraseña y
# si tiene o no sesión iniciada.<br>
# No implementa acciones, las mismas son llevadas a cabo por el manejador.
class Usuario
	# El nombre de usuario elegido
	attr_reader :usuario
	# La clave almacenada 
	attr_reader :clave
	# Indica si es el usuario con sesión activa o no
	attr_reader	:esta_logueado
	
	# El nombre del usuario y la clave se asignan al momento de la creación.<br>
	# Por defecto, al momento de la ceación el usuario no tiene sesión activa
	def initialize(usuario_inicial, clave_inicial)
		@usuario = usuario_inicial
		@clave = clave_inicial
		@esta_logueado = false
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
