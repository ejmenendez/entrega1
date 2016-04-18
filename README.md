#Sistema de creación y acceso de usuarios - CMD

Permite crear usuarios y almacenarlos en memoria para luego ingresar al sistema, utiliza tres 
tipos de encriptación para almacenar sus claves

##Antes de comenzar

Éste documento cubre los pasos necesarios para ejecutar el programa en *Linux*.

###Requisitos 

#### Ruby

Tener instalado el Ruby en su computadora. Para comprobar si Ruby está instalado, ingrese el comando
```
$ ruby --version
``` 
en su consola. 

Debería aparecer la versión de Ruby instalada en su sistema. 
El programa fue creado utilizando la versión 
```
ruby 2.0.0p598 
```

Si no tiene Ruby instalado, puede consultar cómo instalarlo en [ésta página](https://www.ruby-lang.org/es/downloads/)

#### Bundler (Recomendado)

La gema bundler le permitirá instalar las dependencias necesarias para ejecutar el programa.
La misma se instala ingresando el siguiente comando:
```
$ gem install bundler
```

##Instalación

Descargue los archivos contenidos en el repositorio. A la derecha, sobre la lista de archivos 
hay disponible una opción para descargar todo como un archivo *.zip*

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
$ gem install 'bcrypt-ruby'
$ gem install 'simplecov'
```
Para comprobar si todas las dependencias necesarias están instaladas, ejecute el programa
ingresando en la consola:
```
$ ruby cmd.rb
```

en el directorio donde descargó/descomprimió el programa.
