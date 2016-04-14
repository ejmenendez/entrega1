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

				menu.choice(:Login) do
					say "Logueando..."
				end	
				menu.choice(:Logout) do
					say "Deslogueando..."
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
end
