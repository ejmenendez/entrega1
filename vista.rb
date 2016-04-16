require_relative 'controlador'
require_relative 'usuario_o_clave_error'
require_relative 'usuario_ya_existente_error'

class Vista
	attr_reader :controlador
	
	def initialize
		@controlador = Controlador.new
		dibujar
	end

	def dibujar
		salir = false
		say "Tipo de encriptación: #{controlador.tipo_encriptacion}"
		while !salir do 
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
					say "Cambiar"
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
	
	# Método para el login con ingreso de usuario y clave
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
	
	# Método para la creación de un usuario nuevo
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
	
	
end
