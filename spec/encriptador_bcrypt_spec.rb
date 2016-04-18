require_relative '../encriptador_bcrypt'
require 'spec_helper'

describe EncriptadorBCrypt do
	let (:encriptador) {EncriptadorBCrypt.new}
	
	describe "encriptar" do
	
		it "Se encripta la clave enviada" do
			clave = "clave1._-"
			encriptada = encriptador.encriptar clave
			
			expect(encriptada == "clave1._-" ).to be true
		end
		
		it "Se produce una excepción si envío una clave con caracteres no permitidos " do
			expect {
				encriptador.encriptar "@clave¿"
				}.to raise_error CaracterNoValidoError
		end
		
	end
	
	describe "cadena_valida?" do
	
		it "La clave con caracteres permitidos devuelve verdadero en la validación" do
			expect(encriptador.cadena_valida? "unaClave-._" ).to be true
		end
		
		it "Clave con caracteres no válidos" do
			expect {
				encriptador.cadena_valida? "una clave"
				}.to raise_error CaracterNoValidoError
				
			expect {
				encriptador.cadena_valida? "%$#!=" 
				}.to raise_error CaracterNoValidoError
		end
		
		it "Si tiene menos de 4 caracteres no es válida" do
			expect {
				encriptador.cadena_valida? "" 
				}.to raise_error CaracterNoValidoError
			
			expect {
				encriptador.cadena_valida? "123" 
				}.to raise_error CaracterNoValidoError
		end
	end
	
	describe "clave_valida?" do
		
		let	(:encriptada) {encriptador.encriptar "unaClave"}
		
		it "Valida dos claves iguales" do
			expect(encriptador.clave_valida? "unaClave", encriptada).to be true
		end
		
		it "Si la clave es distinta a la encriptada, no es válida" do
			expect(encriptador.clave_valida? "otraClave", encriptada).to be false
		end
	
	end
	
	
end
