require_relative 'usuario'
require_relative 'usuario_o_clave_error'
require_relative 'usuario_ya_existente_error'

class Manejador_usuarios
		
	def initialize
		@lista_usuarios = []
	end
	
	# Devuelve true si algún usuario está logueado en el sistema
	def hay_usuario_logueado?
		@lista_usuarios.any? { |usuario| usuario.esta_logueado }
	end
	
	# Agrega un usuario a la lista con el usuario y clave enviados por parámetro
	# siempre que no exista un usuario igual
	def agregar_usuario(usuario, clave)
		if @lista_usuarios.any? { |usr| usr.usuario.eql? usuario }
			# ya existe el usuario
			raise UsuarioYaExistenteError.new
		end
		
		@lista_usuarios.push(Usuario.new(usuario, clave))
	end
	
	# Comprueba si el usuario y la clave enviados pertenecen a algún usuario que esté
	# actualmente en la colección
	def ingresar(usuario, clave)
		if @lista_usuarios.any? { |usr| usr.control_ingreso(usuario, clave) }
			# éste return debe ser explícito
			return true
		end
		
		# en este punto, no coincide lo enviado con  ningún usuario y contraseña
		raise UsuarioOClaveError.new 
	end
		
end
