require_relative 'controlador'

# Dibuja el menú principal, los submenús y los mensajes.<br>
# Envía al controlador los datos ingresados por el usuario para iniciar, cerrar sesión
# crear usuarios o verificar el estado actual
class Vista
		
	# Instancia el controlador.<br>
	# Asigna los valores para validar la clave de acuerdo a la encriptación que se esté
	# utilizando.<br>
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
			puts "Tipo de encriptación: \e[34m#{@controlador.tipo_encriptacion}\e[0m"
					
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
					# Si hay una sesión activa, la cierra antes de salir
					if @controlador.hay_usuario_logueado?
						cerrar_sesion
					end
					mensaje_info "Saliendo del programa."
					salir = true
				end
			end

		end
	end
	
	# Método que toma los datos e intenta ingresar con el usuario y clave ingresados
	def ingresar
		begin
			# usuario = ask("Ingrese su usuario: ") {}
			usuario = ingresar_usuario
			
			# El usuario debería conocer su clave, por lo que no se chequean los caracteres que ingresa
			clave = ingresar_clave

			@controlador.ingresar(usuario, clave)
			mensaje_ok "Ingreso exitoso!"
		rescue UsuarioOClaveError 
			mensaje_error "El usuario o la clave ingresada son incorrectos"
		rescue UsuarioYaLogueadoError
			# En caso de fallar el menú y querer ingresar con un usuario ya activo
			mensaje_error "Ya hay una sesión activa"
		rescue CaracterNoValidoError
			# En caso de fallar la validación del usuario en la vista
			mensaje_error "El usuario ingresado tiene caracteres no válidos"
		end
	end
	
	# Método que toma los datos para la creación de un usuario nuevo e intenta crearlo:<br>
	# se ingresa el usuario y la clave dos veces para confirmarlas.<br>
	# Las claves ingresadas deben coincidir para poder dar de alta al usuario,
	# y no debe haber otro usuario con el mismo nombre.
	def crear_usuario
		begin
			# usuario = ask("Ingrese usuario: ") {}
			usuario = ingresar_usuario
			
			clave = ingresar_clave(@regexp_clave , @msj_error_clave)
			conf_clave = ingresar_clave(@regexp_clave , @msj_error_clave , "Confirme la clave: ")
			
			if clave.eql? conf_clave
				@controlador.crear_usuario(usuario, clave)
				mensaje_ok "Usuario creado!"
			else
				mensaje_error "Las claves ingresadas no coinciden!"
			end
	
		rescue UsuarioYaExistenteError
			# Ya hay un usuario con el nombre elegido
			mensaje_error "El usuario que intenta crear ya existe"
		rescue CaracterNoValidoError
			# En caso que haya llegado al servidor una clave con algún caracter incorrecto
			mensaje_error "El usuario y/o la clave elegida contienen caracteres no válidos"
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
		mensaje_ok "Encriptación cambiada a: #{@controlador.tipo_encriptacion}"
	end
	
	# Espera el ingreso de la cadena que se va a utilizar como clave
	def ingresar_clave(regexp = nil, mensaje = nil, texto = "Ingrese clave: ")
		ingresar_datos(regexp, mensaje, texto, "*")
	end
	
	# Espera el ingreso de la cadena que se va a utlizar como usuario
	# Caracteres permitidos: letras, números, ., - y _
	def ingresar_usuario
		ingresar_datos(/\A[A-Za-z0-9_\-\.]{4,}\z/, "El usuario debe tener al menos 4 caracteres \ny sólo puede contener letras, números, puntos y guiones (- y _)", "Ingrese el usuario: ")
	end
	
	# Espera el ingreso de una cadena. <br>
	# Muestra el texto enviado por parámetro.<br>
	# Si se envía una regular expression, valida que lo ingresado coincida con la misma, si esto no sucede 
	# muestra un mensaje enviado por parámetro u otro por defecto.<br>
	# Se le puede enviar un caracter para que muestre por cada caracter ingresado, por defecto
	# muestra lo que se va ingresando
	def ingresar_datos(regexp = nil, mensaje = nil, texto = ">>", echo = true)		
		ask(texto) do  |q| 
			q.echo = echo
			if regexp != nil 
				q.validate = regexp  
				q.responses[:not_valid] = mensaje != nil ? mensaje : "La clave contiene caracteres incorrectos"
			end
		end
	end
	
	# Asigna a la regexp y el mensaje de error a utilizar para validar las claves ingresadas
	# los valores que envía el controlador
	def cargar_validador_clave
		@regexp_clave 	 = @controlador.regexp_clave
		@msj_error_clave = @controlador.msj_error_clave
	end
	
	# Muestra si hay algún usuario con sesión iniciada actualmente.<br>
	# Si es así, muestra el nombre de dicho usuario.<br>
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
	
	# Cierra la sesión actual.
	def cerrar_sesion
		begin
			mensaje_ok "Cerrando la sesión para el usuario #{@controlador.nombre_usuario_logueado}"
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
	
	# Muestra un mensaje enviado por parámetro en el color enviado por parámetro.<br>
	# Luego espera a que se presione enter.<br>
	# Por defecto el color de la letra es gris.
	def mostrar_mensaje(color = 37, mensaje)
		puts "\e[#{color}m#{mensaje}\e[0m"
		presione_enter
	end
	
	# Espera a que se presione enter
	def presione_enter
		ask("Presione ENTER para continuar...") {|q| q.echo = false}
	end
	
end
