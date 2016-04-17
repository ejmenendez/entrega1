require_relative '../usuario'

describe Usuario do
	
	let (:usuario) {Usuario.new "admin", "admin"}
		
	describe "initialize" do

		it "Toma los valores de usuario y clave al crearse, no está logueado" do
			expect(usuario.usuario).to eql "admin"
			expect(usuario.clave).to eql "admin"
			expect(usuario.esta_logueado).to be false
		end

		it "Sólo se puede crear un usuario enviándole usuario y clave" do
			expect {Usuario.new}.to raise_error ArgumentError
		end
	end
	
	describe "iniciar_sesion" do
	
		it "El usuario debe tener la sesión activa una vez llamado #iniciar:_sesion" do
			usuario.iniciar_sesion
			expect(usuario.esta_logueado).to be true
		end
	end
	
	describe "cerrar_sesion" do
		
		before :each do
			usuario.iniciar_sesion
		end
		
		it "el usuario no tiene sesión activa una vez llamado #cerrar_sesion" do
			usuario.cerrar_sesion
			expect(usuario.esta_logueado).to be false
		end

	end
end
