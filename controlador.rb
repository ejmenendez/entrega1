require_relative 'encriptador'

class Controlador
	
	attr_reader :encriptador
	
	def initialize
		@encriptador = Encriptador.new
	end
	
	def tipo_encriptacion
		encriptador.tipo_encriptacion
	end
	

end
