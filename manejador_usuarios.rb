require_relative 'usuario'
require_relative 'usuario_exception'

class Manejador_usuarios
	
	attr_accessor :lista_usuarios
	
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
		lista_usuarios.each do |usr|
			if usr.usuario.eql? usuario
				# ya existe el usuario
				raise UsuarioYaExistenteError.new
			end
		end
		@lista_usuarios.push(Usuario.new(usuario, clave))
	end
	
	# Comprueba si el usuario y la clave enviados pertenecen a algún usuario que esté
	# actualmente en la colección
	def ingresar(usuario, clave)
		lista_usuarios.each do |usr|
			if usr.control_ingreso(usuario, clave)
				return true
			end
		end
		
		# en este punto, no coincide lo enviado con  ningún usuario o contraseña
		raise UsuarioOClaveError.new 
	end
		
end
