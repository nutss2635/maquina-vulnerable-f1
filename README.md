# Máquina Vulnerable — Temática F1

Proyecto de Electivo Hacking Ético y Pentesting Aplicado - Universidad del Bío-Bío.

## Descripción

Máquina vulnerable de dificultad fácil, construida con Docker, que aborda 6 categorías
de vulnerabilidades encadenadas de forma progresiva (cada una entrega la información
necesaria para avanzar a la siguiente), culminando en escalada de privilegios hasta
root:

- Aplicaciones web (RCE + fuerza bruta SSH)
- Criptografía clásica (César)
- Esteganografía (steghide)
- Criptografía moderna (XOR)
- Análisis forense (logs de Apache)
- Ingeniería inversa (binario ofuscado con NOT)
- Escalada de privilegios (cron mal configurado)

## Tecnologías usadas

Docker, Debian (imagen base), Apache2, PHP, OpenSSH, steghide, gcc, cron, croc.

## Cómo construir la máquina

Con Docker instalado, desde la raíz de este repositorio:

```bash
docker build -t maquina-vulnerable-f1 .
```

Esto reconstruye la máquina completa desde cero: instala todos los servicios,
copia cada archivo de vulnerabilidad en su ruta correspondiente, compila el
binario de ingeniería inversa, y configura los permisos inseguros necesarios.

## Cómo ejecutarla

```bash
docker run -d -p 2222:22 -p 8080:80 --name vulnerable-f1 maquina-vulnerable-f1
```

- Puerto 22 del contenedor -> 2222 en el host
- Puerto 80 del contenedor -> 8080 en el host

## Cómo generar el .tar (si se necesita para entrega en Moodle)

```bash
docker save -o maquina-vulnerable-f1.tar maquina-vulnerable-f1:latest
```

## Estructura del repositorio

```
maquina-vulnerable-f1/
├── README.md
├── Dockerfile
├── web/
│   ├── index.php                  (vulnerabilidad RCE)
│   └── assets/notas_boxes.txt     (Cesar #1)
├── juan/
│   ├── monaco/pista.txt           (Cesar #2)
│   ├── Downloads/monoplaza.jpg    (esteganografia, steghide)
│   ├── ingenieria/secreto.bin     (XOR)
│   ├── reto_final/
│   │   ├── verifica.c             (fuente, se compila y se borra en el build)
│   │   └── README.txt
│   ├── Documents/, Pictures/, Trabajo/, Facturas/, Recetas/, scripts/, .config/
│   │   (carpetas y archivos señuelo, sin relacion con las vulnerabilidades)
│   ├── bash_history
│   └── notas.txt
├── forensics/
│   └── access_backup.log          (analisis forense)
├── privesc/
│   ├── backup_paddock.sh          (escalada de privilegios)
│   └── cron_backup_paddock
└── docs/
    └── writeup.pdf                  (write-up completo del proyecto)
```

## Cadena de explotación completa

```
1. nmap -> puertos 22 y 80 abiertos
2. Fuerza bruta SSH (hydra) -> juan/1234                        [APLICACIONES WEB]
3. Inspecciona web -> encuentra Cesar #1 -> descifra (shift 7)   [CRIPTOGRAFIA CLASICA]
4. ls -> carpeta monaco -> Cesar #2 -> ruta a Downloads
5. croc + steghide (pass = frase de Cesar #1) -> flag             [ESTEGANOGRAFIA]
6. La flag da clave (33) y ruta -> descifra XOR                    [CRIPTOGRAFIA MODERNA]
7. Mensaje XOR -> revisa access_backup.log -> decodifica base64    [ANALISIS FORENSE]
8. strings + objdump -> detecta NOT -> prueba clave MAX1RED33       [INGENIERIA INVERSA]
9. /opt/backup_paddock.sh con permisos 777 + cron como root
   -> shell de root -> root.txt                                     [ESCALADA PRIVILEGIOS]
```

## Contraseñas y claves (referencia rápida)

- SSH `juan`: `1234`
- Desplazamiento Cesar: `7`
- Frase Cesar #1 / contraseña steghide: `LOS_CARROS_DE_F1_SON_MAS_RAPIDO_EN_PERSONA`
- Clave XOR: `33`
- Clave del binario de ingenieria inversa: `MAX1RED33`

## Autores

[Nombre 1] / [Nombre 2] — Universidad del Bío-Bío
