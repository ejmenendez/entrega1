require_relative '../encriptador_caesar'
require 'spec_helper'

describe EncriptadorCaesar do
	let (:encriptador) {EncriptadorCaesar.new}
	
	describe "encriptar" do
	
		it "Se encripta la clave enviada" do
			clave = "CLAVE" 
			encriptada = encriptador.encriptar clave
			expect(encriptada).not_to eql clave
			expect(EncriptadorCaesar.new.encriptar "CLAVE").to eql encriptada
		end
		
		it "Se produce una excepción si envío una clave con caracteres no alfabéticos " do
			expect {
				encriptador.encriptar "CLAVE1"
				}.to raise_error CaracterNoValidoError
		end
		
	end
	
	describe "desencriptar" do
	
		it "La clave desencriptada debe coincidir con la original" do
			clave = "CLAVE" 
			encriptada = encriptador.encriptar clave
			expect(encriptada).not_to eql clave
			
			expect(encriptador.desencriptar encriptada).to eql clave
		end
		
		it "Se produce una excepción si envío una clave con caracteres no alfabéticos " do
			expect {
				encriptador.desencriptar "CLAVE1"
				}.to raise_error CaracterNoValidoError
		end
		
	end
	
	describe "cadena_valida?" do
	
		it "La clave alfabética devuelve verdadero en la validación" do
			expect(encriptador.cadena_valida? "CLAVE" ).to be true
		end
		
		it "Si tiene al menos un caracter no alfabético, no es válida" do
			expect(encriptador.cadena_valida? "CLAVE1" ).to be nil
			expect(encriptador.cadena_valida? "111111" ).to be nil
		end
		
		it "Si tiene menos de 4 caracteres no es válida" do
			expect(encriptador.cadena_valida? "" ).to be nil
			expect(encriptador.cadena_valida? "CLA" ).to be nil
		end
	end
	
	describe "clave_valida?" do
		
		it "Valida dos claves iguales" do
			encriptada = encriptador.encriptar "CLAVE" 
			expect(encriptador.clave_valida? "CLAVE", encriptada).to be true
		end
		
		it "Si la clave es distinta a la encriptada, no es válida" do
			encriptada = encriptador.encriptar "CLAVE" 
			expect(encriptador.clave_valida? "OTRACLAVE", encriptada).to be false
		end
	
	end
	
	
end
