require_relative '../manejador_usuarios'

describe ManejadorUsuarios do
	
	let (:manejador) {ManejadorUsuarios.new}
	
	describe "initialize" do
		
		it "No tiene usuarios creados al inicio" do
			expect(manejador.hay_usuario_logueado?).to be false
			
			expect {
				manejador.usuario_logueado
				}.to raise_error NoHayUsuarioLogueadoError
			
			expect {
				manejador.cerrar_sesion
				}.to raise_error NoHayUsuarioLogueadoError
			
			expect {
				manejador.nombre_usuario_logueado
				}.to raise_error NoHayUsuarioLogueadoError
				
			expect {
				manejador.ingresar "admin", "admin"
				}.to raise_error UsuarioOClaveError
		end
	
	end
	
	describe "hay_usuario_logueado?" do
			
		before :each do
			manejador.agregar_usuario "admin", "admin"
		end
		
		it "devuelve verdadero o falso de acuerdo a si se inició sesión o no" do
			manejador.ingresar "admin", "admin" 
			expect(manejador.hay_usuario_logueado?).to be true
			
			manejador.cerrar_sesion
			expect(manejador.hay_usuario_logueado?).to be false
		end
	
	end

	describe "agregar_usuario" do
		
		before :each do
			manejador.agregar_usuario "admin", "admin"
		end
		
		it "El usuario está agregado y debería poder iniciar sesión" do
			expect(manejador.ingresar "admin", "admin").to be true
		end	
		
		it "No se pueden agregar usuarios con caracteres no válidos en el nombre" do
			expect {
				manejador.agregar_usuario "%admin!", "admin"
				}.to raise_error CaracterNoValidoError
		end
		
		it "No debería poder agregar otro usuario con el mismo nombre" do
			expect {
				manejador.agregar_usuario "admin", "admin"
				}.to raise_error UsuarioYaExistenteError
		end
		
	end
	
	describe "ingresar" do
		
		before :each do
			manejador.agregar_usuario "admin", "admin"
		end
		
		it "Ingreso de un usuario existente " do
			expect(manejador.ingresar "admin", "admin").to be true
		end
		
		it "Intento de ingreso con usuario erróneo" do
			expect {
				manejador.ingresar "otroUsuario", "admin"
				}.to raise_error UsuarioOClaveError
		end
		
		it "Intento de ingreso con clave errónea" do
			expect {
				manejador.ingresar "admin", "otraClave"
				}.to raise_error UsuarioOClaveError
		end
		
		it "Intento de ingreso con usuario y clave erróneos" do
			expect {
				manejador.ingresar "otroUsuario", "otraClave"
				}.to raise_error UsuarioOClaveError
		end
		
		it "Intento de ingreso con un usuario ya ingresado" do
			manejador.ingresar "admin", "admin"
			manejador.agregar_usuario "otroUsuario", "otraClave"
			
			expect {
				manejador.ingresar "otroUsuario", "otraClave"
				}.to raise_error UsuarioYaLogueadoError
		end
		
		it "Intento de ingreso con un usuario con caracteres no válidos en el nombre" do
			expect {
				manejador.agregar_usuario "%admin!", "admin"
				}.to raise_error CaracterNoValidoError
		end
	end
	
	describe "nombre_usuario_valido?" do
		
		it "Si el nombre de usuario es válido, devuelve true" do
			expect(manejador.nombre_usuario_valido? "admin").to be true
		end
		
		it "Si el nombre de usuario tiene algún caracter no válido se levanta error" do
			expect {
					manejador.nombre_usuario_valido? "%admin!"
					}.to raise_error CaracterNoValidoError
		end
	end
	
	describe "tipo_encriptador" do
		
		it "Los strings de tipo de encriptación del entriptador y el manejador deberían ser iguales" do
			manejador.cambiar_encriptacion_caesar
			expect(manejador.tipo_encriptacion).to eql EncriptadorCaesar.new.tipo_encriptacion
		end
		
	end
	
	describe "cambiar_encriptacion_texto_plano" do
		
		it "El manejador tiene una instancia de EncriptadortextoPlano" do
			manejador.cambiar_encriptacion_texto_plano
			expect(manejador.encriptador).to be_kind_of(EncriptadorTextoPlano)
		end

	end
	
	describe "cambiar_encriptacion_caesar" do
		
		it "El manejador tiene una instancia de EncriptadorCaesar" do
			manejador.cambiar_encriptacion_caesar
			expect(manejador.encriptador).to be_kind_of(EncriptadorCaesar)
		end

	end
	
	describe "cambiar_encriptacion_bcrypt" do
		
		it "El manejador tiene una instancia de EncriptadorBCrypt" do
			manejador.cambiar_encriptacion_bcrypt
			expect(manejador.encriptador).to be_kind_of(EncriptadorBCrypt)
		end

	end
	
	describe "regexp_clave" do
		it "Los strings de la regular expression del encriptador y del manejador son iguales" do
			manejador.cambiar_encriptacion_caesar
			expect(manejador.regexp_clave).to eql EncriptadorCaesar.new.regexp_clave
		end
	end
	
	describe "regexp_clave" do
		it "Los strings del mensaje de error del encriptador y del manejador son iguales" do
			manejador.cambiar_encriptacion_caesar
			expect(manejador.msj_error_clave).to eql EncriptadorCaesar.new.msj_error_clave
		end
	end
	
	describe "nombre_usuario_logueado" do
		
		it "El nombre del usuario ingresado devuelto debería coincidir con el del usuario que ingresó" do
			manejador.agregar_usuario "admin", "admin"
			manejador.ingresar "admin", "admin"
			expect(manejador.nombre_usuario_logueado).to eql "admin"
		end
		
		it "Si no hay usuario ingresado, se levanta una excepción" do
			expect {
				manejador.nombre_usuario_logueado
				}.to raise_error NoHayUsuarioLogueadoError
		end 
		
	end
	
	describe "usuario_logueado" do
		
		it "El usuario ingresado devuelto debería coincidir con el usuario que ingresó" do
			manejador.agregar_usuario "admin", "admin"
			manejador.ingresar "admin", "admin"
			expect(manejador.usuario_logueado.usuario).to eql "admin"
			expect(manejador.usuario_logueado.clave).to eql "admin"
			expect(manejador.usuario_logueado.esta_logueado).to be true
		end
		
		it "Si no hay usuario ingresado, se levanta una excepción" do
			expect {
				manejador.nombre_usuario_logueado
				}.to raise_error NoHayUsuarioLogueadoError
		end 
		
	end
	
	describe "cerrar_sesion" do
	
		it "Si no hay usuario ingresado, no se puede cerrar sesión" do
			expect {
				manejador.nombre_usuario_logueado
				}.to raise_error NoHayUsuarioLogueadoError
		end 
		
		it "Se cierra la sesión, por lo que no debe haber usuarios logueados" do
			manejador.agregar_usuario "admin", "admin"
			manejador.ingresar "admin", "admin"
			expect(manejador.hay_usuario_logueado?).to be true
			
			manejador.cerrar_sesion
			expect(manejador.hay_usuario_logueado?).to be false
		end
	end
	
end


