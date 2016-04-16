require_relative 'usuario'
require_relative 'usuario_o_clave_error'
require_relative 'usuario_ya_existente_error'
require_relative 'encriptador_texto_plano'
require_relative 'encriptador_caesar'
require_relative 'encriptador_bcrypt'

class ManejadorUsuarios
	attr_reader :encriptador
	
	def initialize
		cambiar_encriptacion_caesar
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
		@lista_usuarios.push(Usuario.new(usuario, @encriptador.encriptar(clave)))
	end
	
	# Comprueba si el usuario y la clave enviados pertenecen a algún usuario que esté
	# actualmente en la colección
	def ingresar(usuario, clave)
		@lista_usuarios.each do |usr| 
			if usr.usuario.eql? usuario 
				# si el usuario existe, se comprueba la clave
				if @encriptador.validar_clave(clave, usr.clave)
					usr.iniciar_sesion
					# éste return debe ser explícito
					return true
				end
			end
		end
				
		# en este punto, no coincide lo enviado con  ningún usuario y contraseña
		raise UsuarioOClaveError.new 
	end
	
	# Devuelve un String con el nombre del tipo de encriptación actual
	def tipo_encriptacion
		@encriptador.tipo_encriptacion
	end
	
	# Cambia el tipo de encriptación a texto plano
	def cambiar_encriptacion_texto_plano
		@encriptador = EncriptadorTextoPlano.new
	end
	
	# Cambia el tipo de encriptación a Caesar's Cypher
	def cambiar_encriptacion_caesar
		@encriptador = EncriptadorCaesar.new
	end
	
	# Cambia el tipo de encriptación a BCrypt
	def cambiar_encriptacion_bcrypt
		@encriptador = EncriptadorBCrypt.new
	end
		
end
