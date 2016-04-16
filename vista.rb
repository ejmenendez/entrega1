require_relative 'controlador'

class Vista
	attr_reader :controlador
	
	def initialize
		@controlador 		= Controlador.new
		cargar_validador_clave
		dibujar
	end
	
	# Muestra en pantalla el menú principal
	def dibujar
		salir = false
		
		while !salir do 
			say "Tipo de encriptación: #{controlador.tipo_encriptacion}"
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
	
	# Método que toma los datos y ejecuta el login con el usuario y clave ingresados
	def ingresar
		begin
			usuario = ask("Ingrese su usuario: ") {}
			clave = ingresar_clave
			controlador.ingresar(usuario, clave)
			puts "Ingreso exitoso!"
		rescue UsuarioOClaveError 
			puts "El usuario o la clave ingresada son incorrectos"
		rescue UsuarioYaLogueadoError
			puts "Ya hay una sesión activa"
			mostrar_estado
		end
	end
	
	# Método que toma los datos para la creación de un usuario nuevo e intenta crearlo
	def crear_usuario
		begin
			usuario = ask("Ingrese usuario: ") {}
			clave = ingresar_clave(@regexp_clave , @msj_error_clave)
			conf_clave = ingresar_clave(@regexp_clave , @msj_error_clave , "Confirme la clave: ")
			
			if clave.eql? conf_clave
				controlador.crear_usuario(usuario, clave)
				puts "Usuario creado!"
			else
				puts "Las claves ingresadas no coinciden!"
			end
	
		rescue UsuarioYaExistenteError
			puts "El usuario que intenta crear ya existe"
		rescue CaracterNoValidoError
			# En caso que haya llegado al servidor una clave con algún caracter incorrecto
			puts "La clave elegida contiene caracteres erróneos"
		end
	end
	
	# Método que muestra el menú para cambiar de encriptación
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
				puts "Su sesión está activa con el usuario: #{@controlador.nombre_usuario_logueado}"
			else
				puts "Usted no ha iniciado sesión"
			end
		rescue NoHayUsuarioLogueadoError
			# No debería suceder...
			puts "No hay usuario con sesión activa para mostrar!!"
		end
	end
	
	# Cierra la sesión del usuario actual
	def cerrar_sesion
		begin
			@controlador.cerrar_sesion
		rescue
			# No debería suceder...
			puts "No hay usuario con sesión activa en éste momento!!"
		end
	end
	
end
