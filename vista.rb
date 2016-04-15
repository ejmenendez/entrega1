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
	
	def ingresar
		usuario = ask("Ingrese su usuario: ") {}
		clave	= ask("Ingrese su clave: ") { |q| q.echo = "*" }
		
		if controlador.ingresar(usuario, clave)
			puts "Ingreso exitoso!"
		end
	end
	
	def crear_usuario
	
	
	end
	
	
end
