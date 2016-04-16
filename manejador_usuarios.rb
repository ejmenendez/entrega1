require_relative 'usuario'
require_relative 'usuario_o_clave_error'
require_relative 'usuario_ya_existente_error'
require_relative 'usuario_ya_logueado_error'
require_relative 'no_hay_usuario_logueado_error'
require_relative 'encriptador_texto_plano'
require_relative 'encriptador_caesar'
require_relative 'encriptador_bcrypt'

# Contiene una lista de usuarios existentes en el sistema. 
# Realiza las tareas de ingreso, cierre de sesión, cambio de encriptación, y envío
# de lo datos del usuario con sesión iniciada y el encriptador en uso.
# Contiene el encriptador que se utiliza para las claves de los usuarios.
class ManejadorUsuarios
	# El encriptador que se utiliza en el sistema
	attr_reader :encriptador
	
	# Inicializa la lista de usuarios y carga el encriptador por defecto
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
	# Si existe, levanta un UsuarioYaExistenteError
	def agregar_usuario(usuario, clave)
		if @lista_usuarios.any? { |usr| usr.usuario.eql? usuario }
			# ya existe el usuario
			raise UsuarioYaExistenteError.new
		end
		@lista_usuarios.push(Usuario.new(usuario, @encriptador.encriptar(clave)))
	end
	
	# Comprueba si el usuario y la clave enviados pertenecen a algún usuario que esté
	# actualmente en la colección
	# Si ya hay un usuario logueado, levanta un UsuarioYaLogueadoError
	def ingresar(usuario, clave)
		if ! hay_usuario_logueado?
			
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
		else
			raise UsuarioYaLogueadoError.new
		end
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
	
	# Devuelve la regexp a utilizarse para el ingreso de claves del encriptador actual
	def regexp_clave
		@encriptador.regexp_clave
	end
	
	# Devuelve el mensaje de error asociado a la regexp de ingreso de claves del encriptador
	# actual. Elmensaje se muestra si la clave ingresada no cumple con la regexp
	def msj_error_clave
		@encriptador.msj_error_clave
	end
	
	# Devuelve el nick del usuario logueado actualmente, si hay alguno
	# Si no hay ninguno, devuelve un NoHayUsuarioLogueadoError
	def nombre_usuario_logueado	
		usuario_logueado.usuario
	end
	
	# Devuelve el usuario logueado actualmente
	# Si no hay ninguno, levanta un NoHayUsuarioLogueadoError
	def usuario_logueado
		if hay_usuario_logueado?
			usuarios = @lista_usuarios.select { |usuario| usuario.esta_logueado }
			# hay un sólo usuario logueado
			usuarios[0]
		else
			raise NoHayUsuarioLogueadoError.new
		end
	end	
	
	# Cierra la sesión del usuario actual
	# Si no hay ninguno, devuelve un NoHayUsuarioLogueadoError
	def cerrar_sesion
		usuario_logueado.cerrar_sesion
	end
	
end
