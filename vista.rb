require_relative 'controlador'

class Vista
	attr_reader :controlador
	
	def initialize
		@controlador = Controlador.new
		dibujar
	end

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
					menu.choice(:Cerrar_Sesión) do
						say "Deslogueando..."
					end
				end
				
				menu.choice(:Cambiar_Encriptación) do
					cambiar_encriptacion
				end
				
				menu.choice(:Estado) do
					say "Tu estado es"
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
			clave	= ask("Ingrese su clave: ") { |q| q.echo = "*" }
			
			controlador.ingresar(usuario, clave)
			puts "Ingreso exitoso!"
			
		rescue UsuarioOClaveError 
			puts "El usuario o la clave ingresada son incorrectos"
		end
	end
	
	# Método que toma los datos para la creación de un usuario nuevo e intenta crearlo
	def crear_usuario
		begin
			usuario = ask("Ingrese usuario: ") {}
			clave	= ask("Ingrese clave: ") do  |q| 
				q.echo = "*" 
				q.validate = /[A-Za-z]/  
				q.responses[:not_valid] = "La clave debe contener sólo caracteres de la A a la Z"
			end
			
			conf_clave	= ask("Confirme la clave: ") do  |q| 
				q.echo = "*" 
				q.validate = /[A-Za-z]/  
				q.responses[:not_valid] = "La clave debe contener sólo caracteres de la A a la Z"
			end
			
			if clave.eql? conf_clave
				controlador.crear_usuario(usuario, clave)
				puts "Usuario creado!"
			else
				puts "Las claves ingresadas no coinciden!"
			end
		rescue UsuarioYaExistenteError
			puts "El usuario que quiere crear ya existe"
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
	end
	
	
	
end
