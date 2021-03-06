require_relative 'manejador_usuarios'

# Hace de inerfaz entre la vista y los modelos. 
class Controlador

	# Crea una instancia del manejador de usuarios.<br>
	# Crea un usuario de prueba 
	def initialize
		@manejador   = ManejadorUsuarios.new
		crear_usuario("admin", "admin")
	end
	
	# Devuelve un String con el nombre del tipo de encriptación actual
	def tipo_encriptacion
		@manejador.tipo_encriptacion
	end
	
	# Indica si hay algún usuario logueado en el sistema actualmente
	def hay_usuario_logueado?
		@manejador.hay_usuario_logueado?
	end
	
	# intenta ingresar al sistema con el usuario y la clave enviados
	def ingresar(usuario, clave)
		@manejador.ingresar(usuario, clave)
	end
	
	# Crea un usuario nuevo
	def crear_usuario(usuario, clave)
		@manejador.agregar_usuario(usuario, clave)
	end
	
	# Cambia el tipo de encriptación a texto plano en el manejador
	def cambiar_encriptacion_texto_plano
		@manejador.cambiar_encriptacion_texto_plano
	end
	
	# Cambia el tipo de encriptación a Caesar's Cypher en el manejador
	def cambiar_encriptacion_caesar
		@manejador.cambiar_encriptacion_caesar
	end
	
	# Cambia el tipo de encriptación a BCrypt en el manejador
	def cambiar_encriptacion_bcrypt
		@manejador.cambiar_encriptacion_bcrypt
	end
	
	# Devuelve la regexp a utilizarse para el ingreso de claves del encriptador actual
	def regexp_clave
		@manejador.regexp_clave
	end
	
	# Devuelve el mensaje de error asociado a la regexp de ingreso de claves del encriptador
	# actual.
	def msj_error_clave
		@manejador.msj_error_clave
	end
	
	# Devuelve el nombre del usuario que tiene sesión activa al momento de ser invocado.
	def nombre_usuario_logueado
		@manejador.nombre_usuario_logueado
	end
	
	# Cierra la sesión del usuario actual
	def cerrar_sesion
		@manejador.cerrar_sesion
	end
end
