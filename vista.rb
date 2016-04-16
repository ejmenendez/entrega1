require_relative 'controlador'

# Dibuja el menú principal, los submenús y los mensajes.
class Vista
		
	# Instancia el controlador.
	# Asigna los valores para validar la clave de acuerdo a la encriptación que se esté
	# utilizando.
	# Dibuja el menú principal
	def initialize
		@controlador 		= Controlador.new
		cargar_validador_clave
		dibujar
	end
	
	# Muestra en pantalla el menú principal mientras no se seleccione la opción de salir
	# del programa
	def dibujar
		salir = false
		
		while !salir do 
			# Informa la encriptación que se está utilizando actualmente
			puts "Tipo de encriptación: \e[34m#{controlador.tipo_encriptacion}\e[0m"
					
			choose do |menu| 
				
				# la opción de login se muestra sólo si no hay usuario logueados
				# la de log out sólo si sí hay usuario logueado
				if ! @controlador.hay_usuario_logueado?
					menu.choice(:Ingresar) do
						ingresar
					end
					# la opción de crear usuario se muestra sólo si no hay usuario logueado
					menu.choice(:Crear_Usuario) do
						crear_usuario
					end
				else
					# la opción de cerrar sesión se muestra sólo si hay un usuario logueado
					menu.choice(:Cerrar_Sesión) do
						cerrar_sesion
					end
				end
				
				# Las siguientes opciones se muestran independientemente de si hay usuarios
				# logueados o no
				menu.choice(:Cambiar_Encriptación) do
					cambiar_encriptacion
				end
				
				menu.choice(:Estado) do
					mostrar_estado
				end
				
				menu.choice(:Salir) do
					salir = true
				end
			end

		end
	end
	
	# Método que toma los datos e intenta ingresar con el usuario y clave ingresados
	def ingresar
		begin
			usuario = ask("Ingrese su usuario: ") {}
			clave = ingresar_clave
			controlador.ingresar(usuario, clave)
			mensaje_ok "Ingreso exitoso!"
		rescue UsuarioOClaveError 
			mensaje_error "El usuario o la clave ingresada son incorrectos"
		rescue UsuarioYaLogueadoError
			# En caso de fallar el menú y querer ingresar con un usuario ya activo
			mensaje_error "Ya hay una sesión activa"
			mostrar_estado
		end
	end
	
	# Método que toma los datos para la creación de un usuario nuevo e intenta crearlo:
	# se ingresa el usuario y la clave dos veces para confirmarlas.
	# Las claves ingresadas deben coincidir para poder dar de alta al usuario,
	# y no debe haber otro usuario con el mismo nombre.
	def crear_usuario
		begin
			usuario = ask("Ingrese usuario: ") {}
			clave = ingresar_clave(@regexp_clave , @msj_error_clave)
			conf_clave = ingresar_clave(@regexp_clave , @msj_error_clave , "Confirme la clave: ")
			
			if clave.eql? conf_clave
				controlador.crear_usuario(usuario, clave)
				mensaje_ok "Usuario creado!"
			else
				mensaje_error "Las claves ingresadas no coinciden!"
			end
	
		rescue UsuarioYaExistenteError
			# Ya hay un usuario con el nombre elegido
			mensaje_error "El usuario que intenta crear ya existe"
		rescue CaracterNoValidoError
			# En caso que haya llegado al servidor una clave con algún caracter incorrecto
			mensaje_error "La clave elegida contiene caracteres erróneos"
		end
	end
	
	# Método que muestra el menú para cambiar de encriptación, y carga los validadores de
	# clave que correspondan
	def cambiar_encriptacion
		choose do |encriptacion|
			
			encriptacion.choice(:Texto_Plano) do
				@controlador.cambiar_encriptacion_texto_plano
			end 
			
			encriptacion.choice(:Caesars_Cypher) do
				@controlador.cambiar_encriptacion_caesar
			end 
			
			encriptacion.choice(:BCrypt) do
				@controlador.cambiar_encriptacion_bcrypt
			end 
		end
		
		cargar_validador_clave
		mensaje_ok "Encriptación cambiada a: #{controlador.tipo_encriptacion}"
	end
	
	# Espera el ingreso de una cadena que se va a utilizar como clave, si se envía una
	# regular expression valida que lo ingresado sea correcto, en caso de error muestra 
	# un mensaje enviado por parámetro u otro por defecto.
	def ingresar_clave(regexp = nil, mensaje = nil, texto = "Ingrese clave: ")		
		ask(texto) do  |q| 
			q.echo = "*"
			if regexp != nil 
				q.validate = regexp  
				q.responses[:not_valid] = mensaje != nil ? mensaje : "La clave contiene caracteres incorrectos"
			end
		end
	end
	
	# Carga la regexp y el mensaje a utilizar para validar las claves ingresadas
	# según el método de encriptación que se utiliza
	def cargar_validador_clave
		@regexp_clave 	 = @controlador.regexp_clave
		@msj_error_clave = @controlador.msj_error_clave
	end
	
	# Muestra el estado actual del usuario, si está logueado o no
	def mostrar_estado
		begin
			if @controlador.hay_usuario_logueado?
				mensaje_info "Su sesión está activa con el usuario: #{@controlador.nombre_usuario_logueado}"
			else
				mensaje_error "Usted no ha iniciado sesión"
			end
		rescue NoHayUsuarioLogueadoError
			# En el caso que falle el menú y se quiera mostrar el usuario sin haber
			# ninguno logueado
			mensaje_error "No hay usuario con sesión activa para mostrar!!"
		end
	end
	
	# Cierra la sesión del usuario actual
	def cerrar_sesion
		begin
			@controlador.cerrar_sesion
		rescue NoHayUsuarioLogueadoError
			# En caso que falle el menú y se quiera cerrar sesión sin haber usuarios logueados
			mensaje_error "No hay usuario con sesión activa en éste momento!!"
		end
	end
	
	# Muestra un mensaje de error y espera a que se presione enter
	def mensaje_error(mensaje)
		mostrar_mensaje 31, mensaje
	end
	
	# Muestra un mensaje de éxito y espera a que se presione enter
	def mensaje_ok(mensaje)
		mostrar_mensaje 32, mensaje
	end
	
	# Muestra un mensaje informativo y espera a que se presione enter
	def mensaje_info(mensaje)
		mostrar_mensaje 34, mensaje
	end
	
	# Muestra un mensaje con el color enviado por parámetro 
	# Luego espera a que se presione enter
	def mostrar_mensaje(color = 37, mensaje)
		puts "\e[#{color}m#{mensaje}\e[0m"
		presione_una_tecla
	end
	
	# espera a que se presione enter
	def presione_una_tecla
		ask("Presione ENTER para continuar...") {|q| q.echo = false}
	end
	
end
