# litex

**Observación**: 
* Tenga en cuenta que en ocaciones puede requerir permisos de SUPERUSUARIO
* Pueda que no sea suficiente con las instrucciones mostradas a continuación; le invito a abrir `issues` para sugerir ayudas.


## Paquetes que se instalarán en la imagen

* Litex
* Yosys
* Verilator
* Openocd
* Risc-v toolchain
* Lm-32 toolchain

## Generación de imagen en su PC

Para éste fin hay dos maneras posibles de hacerlo:

* Construyendo su propia imagen (haciendo uso del Dockerfile)
* Halando la imagen (hacer pull) desde dockerhub (imagen preconstruida)

A continuación se describe cómo **hacer alguna de estas dos operaciones** (no haga las dos!!!):


### Pull de imagen construida en Dockerhub

```bash
docker pull johnnycubides/litex
```

### Construcción de imagen (de manera manual)

```bash
git clone https://github.com/johnnycubides/litex.git
cd litex
docker build -t litex-img -f Dockerfile .
```

## Instanciar imagen (crear contenedor)

Ubicarse en el directorio que usted eligió para trabajar sus proyectos el cual
compartirá con el contendor y luego haga lo siguiente:

```bash
docker run -v $(pwd):/home --name litex -it -d litex-img
```

## Verificación de contendor creado y corriendo

Al ejecutar el siguiente comando debe aparecer en la lista de los contenedores corriendo

```bash
docker container ps
```

Los contenedores que no están iniciados se pueden ver con el siguiente comando

```bash
docker container ps -a
```

## Hacer uso de el bash del contenedor creado

A partir de acá ya puede hacer uso de las herramientas instaladas; haga uso del siguiente
comando:

```bash
docker exec -it litex bash
```

Atentamente:

Johnny Cubides

jgcubidesc@gmail.com
