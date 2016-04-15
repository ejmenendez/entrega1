require_relative 'controlador'
require_relative 'controlador'

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
					menu.choice(:Salir) do
						say "Deslogueando..."
					end
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
			
		rescue UsuarioError => e
			puts e.message
		end
	end
	
	# Método para la creación de un usuario nuevo
	def crear_usuario
		begin
			usuario = ask("Ingrese usuario: ") {}
			clave	= ask("Ingrese clave: ") { |q| q.echo = "*" }
			conf_clave	= ask("Confirme la clave: ") { |q| q.echo = "*" }
			
			if clave.eql? conf_clave
				controlador.crear_usuario(usuario, clave)
				puts "Usuario creado!"
			else
				puts "Las claves ingresadas no coinciden!"
			end
		rescue UsuarioError => e
			puts e.message
		end
	end
	
	
end
