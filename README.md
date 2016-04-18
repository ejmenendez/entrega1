#Sistema de creación y acceso de usuarios - CMD

Permite crear usuarios y almacenarlos en memoria para luego ingresar al sistema, utiliza tres 
tipos de encriptación para almacenar sus claves

##Antes de comenzar

Éste documento cubre los pasos necesarios para ejecutar el programa en **Linux**.

###Requisitos 

#### Ruby

Tener instalado el Ruby en su computadora. Para comprobar si Ruby está instalado, ingrese el comando
```
$ ruby --version
``` 
en su consola. 

Debería aparecer la versión de Ruby instalada en su sistema. 
El programa fue creado utilizando la versión `ruby 2.0.0p598`

Si no tiene Ruby instalado, puede consultar cómo instalarlo en [ésta página](https://www.ruby-lang.org/es/downloads/)

#### Bundler (Recomendado)

La gema bundler le permitirá instalar las dependencias necesarias para ejecutar el programa.
La misma se instala ingresando el siguiente comando:
```
$ gem install bundler
```

##Instalación

Descargue los archivos contenidos en el repositorio. A la derecha, sobre la lista de archivos, 
hay disponible una opción para descargar todo como un archivo **.zip**

Una vez descargado (y descomprimido en la carpeta elegida, si es el caso), debe descargar las
dependencias necesarias para poder utilizar el programa. Si instaló Bundler, ingrese en la consola:
```
$ bundle install
```
y se descargarán las dependencias necesarias.

Si no instaló Bundler, debe ingresar los siguientes comandos en la consola:
```
$ gem install 'highline'
$ gem install 'rspec'
$ gem install 'bcrypt'
$ gem install 'simplecov'
```
Para comprobar si todas las dependencias necesarias están instaladas, ejecute el programa
ingresando en la consola:
```
$ ruby cmd.rb
```

en el directorio donde descargó/descomprimió el programa.

##Ejecución de los tests

Para ejecutar los tests, debe haber instalado la gema Rspec (ver **Instalación**).
En la línea de comando ingrese
```
$ rspec
```
Y verá los resultados de los tests a medida que se ejecutan. Al mismo tiempo **SimpleCov**,
si fue instalado, genera estadísticas de los tests en el directorio *coverage*.

###Clases testeadas

* EncriptadorBCrypt
	Métodos testeados:
	1. #encriptar
	2. #cadena_valida?
	3. #clave_valida?
* EncriptadorCaesar
	Métodos testeados:
	1. #encriptar
	2. #desencriptar
	3. #cadena_valida?
	4. #clave_valida?
* EncriptadorTextoPlano
	Métodos testeados:
	1. #encriptar
	2. #cadena_valida?
	3. #clave_valida?
* Usuario
	Métodos testeados:
	1. #initialize
	2. #iniciar_sesion
	3. #cerrar_sesion
* ManejadorUsuarios
	Métodos testeados:
	1. #initialize
	2. #hay_usuario_logueado?
	3. #agregar_usuario
	4. #ingresar
	5. #nombre_usuario_valido?
	6. #tipo_encriptador
	7. #cambiar_encriptacion_texto_plano
	8. #cambiar_encriptacion_caesar
	9. #cambiar_encriptacion_bcrypt
	10. #regexp_clave
	11. #msj_error_clave
	12. #nombre_usuario_logueado
	13. #usuario_logueado
	14. #cerrar_sesion

###Clases NO testeadas

* Vista
* Controlador
* Encriptador (posee métodos abstractos)

##Autor

Esteban Menéndez






