# Git and Job (FrontEnd Service)
Frontend para git and job, un sistema de busqueda y aplicación de empleos tanto fijos como gits. Este repositorio tiene como objetivo desplegar el servicio frontend de la aplicación web (backoffice) haciendo uso de la arquitectura BLoC de Flutter.

## 🚀Iniciando 
Estas instrucciones serviran para obtener una copia del proyecto en funcionamiento en su máquina local con el fin de desarollo y realizar pruebas.

### 📋Pre-requisitos 
* [Flutter](https://flutter.dev/) - SDK de código fuente abierto para el desarrollo de aplicaciones web y móviles.
* [Dart](https://dart.dev/) - Lenguaje de Programación.
* [Git](https://git-scm.com/) - Manejador de versiones.
* [GooogleChorme](https://www.google.com/intl/es/chrome/) - Navegador para correr el proyecto.

## 🔧Instalación 
Procedemos a clonar el repositorio
```
git clone https://github.com/TeamTron2021/gigandjob-web.git
```
Despues
```
cd gigandjob-web
```
Para habilitar el uso del navegador web en fluter.
```
flutter config --enable-web
```
Luego, configurar el proyecto con el SDK de flutter.

Para descargar los paquetes en proyectos dart.
```
flutter pub get
```
Ignora cualquier archivo de bloqueo existente, por lo que Pub puede obtener las últimas versiones de todas las dependencias.
```
flutter pub upgrade
```
Este comando permitirá un análisis de los elementos imprescindibles para el correcto funcionamiento del producto.
```
flutter doctor
```
Para correr el proyecto en el navegador web.
```
flutter run -d chrome
``` 
## ⚙️Corriendo pruebas
Para correr los tests necesarios para validar el correcto funcionamiento de los witgets del proyecto necesitamos movernos a la carpeta de tests.
```
cd test
```
Posteriormente haremos uso del comando para correr los tests necesarios
```
flutter test
```
## ✒️Autores
* **Carlos Alonzo** - [cealonzo](https://github.com/cealonzo)
* **Ruben Gomes** - [RubenDGomesdev](https://github.com/RubenDGomesdev)
* **Pablo Perez** - [PabloP16](https://github.com/PabloP16)
* **Andrea Mendoza** - [andreaamg22](https://github.com/andreaamg22)

---
Hecho con ❤️ por [Team Tron](https://github.com/TeamTron2021) 😊
