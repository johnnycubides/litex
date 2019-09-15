# litex

**Observación**: 
* Tenga en cuenta que en ocaciones puede requerir permisos de SUPERUSUARIO
* Pueda que no sea suficiente con las instrucciones mostradas a continuación, le invito a abrir hilos o `issues` para poder sugerir las correspondientes ayudas.


## Paquetes a instalar

* Litex
* yosys
* verilator
* openocd
* risc-v toolchain
* lm-32 toolchain:w

## Construcción de imagen

```bash
git clone https://github.com/johnnycubides/litex.git
cd litex
docker build -t litex-img -f Dockerfile .
```
## Intanciar imagen (crear contenedor)

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
