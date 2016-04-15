
class EncriptadorCaesar
	attr_reader :tipo_encriptacion

	def initialize(shift, alphabet = ('A'..'Z').to_a.join)
		i = shift % alphabet.size 
		@decrypt = alphabet
		@encrypt = alphabet[i..-1] + alphabet[0...i]
		@tipo_encriptacion = "Caesar's Cypher"
	end

	def encriptar(string)
		string.tr(@decrypt, @encrypt)
	end

	def desencriptar(string)
		string.tr(@encrypt, @decrypt)
	end
end
