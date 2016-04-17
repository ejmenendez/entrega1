require_relative '../encriptador_texto_plano'

describe EncriptadorTextoPlano do
	let (:encriptador) {EncriptadorTextoPlano.new}
	
	describe "encriptar" do
	
		it "NO se encripta la clave enviada, por lo que debería ser igual" do
			clave = "clave1._-" 
			encriptada = encriptador.encriptar clave
			
			expect(encriptada).to eql clave
			
			expect(EncriptadorTextoPlano.new.encriptar "clave1._-").to eql encriptada
		end
		
		it "Se produce una excepción si envío una clave con caracteres no permitidos " do
			expect {
				encriptador.encriptar "clave!"
				}.to raise_error CaracterNoValidoError
		end
		
	end
	
	describe "cadena_valida?" do
	
		it "La clave con caracteres permitidos devuelve verdadero en la validación" do
			expect(encriptador.cadena_valida? "unaClave-._" ).to be true
		end
		
		it "Clave con caracteres no válidos" do
			expect(encriptador.cadena_valida? "una clave" ).to be nil
			expect(encriptador.cadena_valida? "%$#!=" ).to be nil
		end
		
		it "Si tiene menos de 4 caracteres no es válida" do
			expect(encriptador.cadena_valida? "" ).to be nil
			expect(encriptador.cadena_valida? "123" ).to be nil
		end
	end
	
	describe "validar_clave" do
		
		it "Valida dos claves iguales" do
			encriptada = encriptador.encriptar "unaClave" 
			expect(encriptador.validar_clave "unaClave", encriptada).to be true
		end
		
		it "Si la clave es distinta a la encriptada, no es válida" do
			encriptada = encriptador.encriptar "unaClave" 
			expect(encriptador.validar_clave "otraClave", encriptada).to be false
		end
	
	end
	
	
end
