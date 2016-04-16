require_relative 'encriptador'
require_relative 'encriptador_caesar'
require_relative 'encriptador_bcrypt'
require_relative 'manejador_usuarios'

class Controlador
	
	attr_reader :encriptador
	attr_reader :manejador
	
	def initialize
		# @encriptador = Encriptador.new
		# @encriptador = EncriptadorCaesar.new(3)
		@encriptador = EncriptadorBCrypt.new
		@manejador   = Manejador_usuarios.new
		# agrego el usuario de prueba
		crear_usuario("admin", "ADMIN")
	end
	
	# Devuelve un String con el nombre del tipo de encriptación actual
	def tipo_encriptacion
		@encriptador.tipo_encriptacion
	end
	
	# Indica si hay algún usuario logueado en el sistema actualmente
	def hay_usuario_logueado?
		@manejador.hay_usuario_logueado?
	end
	
	# intenta ingresar al sistema con el usuario y la clave enviados
	def ingresar(usuario, clave)
		@manejador.ingresar(usuario, @encriptador.encriptar(clave))
	end
	
	# Crea un usuario nuevo
	def crear_usuario(usuario, clave)
		@manejador.agregar_usuario(usuario, @encriptador.encriptar(clave))
	end

end
