# Proyecto final de Electrónica Digital

Controlador de una matriz RGB direccionable de 8 × 32 píxeles mediante FPGA y lenguaje Verilog. El sistema permite visualizar texto desplazable, seleccionar colores mediante interruptores y actualizar el contenido mediante comunicación UART.

La implementación utiliza una interfaz serial compatible con el formato de transmisión WS2812B, con 24 bits por píxel en orden GRB. La arquitectura se divide en módulos de temporización, mapeo de coordenadas, lectura de caracteres, desplazamiento, selección de color y recepción de texto.

## Funcionalidades

- Control de los 256 píxeles de la matriz.
- Mapeo de coordenadas con recorrido en zigzag por columnas.
- Caracteres de 8 × 8 píxeles.
- Desplazamiento horizontal del texto.
- Selección de ocho colores mediante tres interruptores.
- Registro de hasta 32 caracteres en la integración principal.
- Recepción de letras, números y símbolos mediante UART.
- Edición del texto mediante Backspace y Delete.
- Simulaciones independientes de los módulos y pruebas de integración.
- Documentación del diseño, esquemáticos y resultados de simulación.

## Organización del repositorio

| Ruta | Contenido |
|---|---|
| [`main/`](main/) | Módulo principal, testbench de integración y archivos de simulación. |
| [`U_cont/`](U_cont/) | Contadores de reinicio, tiempo de bit, índice de bit e índice de píxel. |
| [`U_map/`](U_map/) | Conversión del índice lineal de píxel a fila y columna. |
| [`U_rom/`](U_rom/) | ROM con patrones de letras, dígitos, signos y símbolos gráficos. |
| [`U_scroll/`](U_scroll/) | Lógica de desplazamiento y selección de la columna del carácter. |
| [`U_color/`](U_color/) | Sincronización de interruptores y selección del color GRB. |
| [`U_frase/`](U_frase/) | Receptor UART, traducción de caracteres y registro de la frase. |
| [`Tests/`](Tests/) | Pruebas iniciales de generación de señales y visualización de una letra. |
| [`Documentacion/`](Documentacion/) | Informe final, resultados, capturas de ondas y esquemáticos. |
| [`DECLARACION_DE_IA.md`](DECLARACION_DE_IA.md) | Declaración de la asistencia de inteligencia artificial utilizada. |

Los archivos `.v` contienen las fuentes del diseño y los bancos de prueba. Los archivos `.vvp` corresponden a ejecutables de simulación generados con Icarus Verilog. Los archivos `.vcd` contienen las señales registradas durante las simulaciones y pueden abrirse con GTKWave.

## Arquitectura

El módulo superior es `main`, definido en `main/main.v`.

| Instancia | Módulo | Función |
|---|---|---|
| `u_cont` | `contadores` | Genera los tiempos e índices de transmisión y las banderas de finalización. |
| `u_map` | `mapeo_matriz` | Obtiene las coordenadas del píxel considerando el recorrido en zigzag. |
| `u_scroll` | `desplazamiento` | Determina el carácter y la columna del glifo que se están mostrando. |
| `u_rom` | `rom_caracteres` | Entrega el patrón de ocho píxeles de la fila seleccionada. |
| `u_color` | `selector_color` | Selecciona y registra el color según los interruptores. |
| `u_frase` | `uart_frase` | Traduce los bytes recibidos y actualiza el registro de texto. |
| `u_frase.u_rx` | `uart_rx` | Recibe los ocho bits de cada byte UART y genera `Dato_valido`. |

A partir de la información de la ROM, `main` determina si el píxel debe encenderse, selecciona su color y transmite sus 24 bits desde el más significativo hasta el menos significativo.

La máquina de estados alterna entre:

- **REINICIO**, durante el cual la salida permanece en nivel bajo.
- **ENVÍO**, durante el cual se transmiten los datos de los 256 píxeles.

## Parámetros de funcionamiento

Los tiempos siguientes corresponden a un reloj de 100 MHz.

| Parámetro | Valor |
|---|---|
| Período de reloj | 10 ns |
| Resolución | 8 filas × 32 columnas |
| Píxeles por cuadro | 256 |
| Bits por píxel | 24 |
| Orden de color | GRB |
| Período de un bit | 125 ciclos, equivalentes a 1,25 µs |
| Nivel alto para un bit cero | 25 ciclos, equivalentes a 250 ns |
| Nivel alto para un bit uno | 88 ciclos, equivalentes a 880 ns |
| Tiempo de reinicio | 28000 ciclos, equivalentes a 280 µs |
| Transmisión de un cuadro | 7,68 ms |
| Ciclo de transmisión y reinicio | Aproximadamente 7,96 ms |
| Capacidad de la frase en `main` | 32 caracteres |
| Ancho del código de carácter | 6 bits |
| Velocidad UART nominal | 115200 baudios |
| Configuración UART | 8 bits de datos, sin paridad y un bit de parada |
| Ciclos de reloj por bit UART | 868 |
| Cuadros por paso en el diseño principal | 12 |

Cada celda de texto ocupa ocho columnas de glifo y una columna de separación. El módulo de desplazamiento antepone cuatro espacios, equivalentes a 36 columnas, para introducir el texto progresivamente en la matriz.

La frase inicial contiene `HOLA`, seguida de espacios hasta completar las 32 posiciones.

## Entradas y salida principales

| Señal | Dirección | Descripción |
|---|---|---|
| `CLK` | Entrada | Reloj de 100 MHz. |
| `Interruptores[2:0]` | Entrada | Selección del color. |
| `UART_RX` | Entrada | Recepción serial del texto. |
| `Datos_LED` | Salida | Señal serial dirigida a la matriz. |

### Selección de colores

El parámetro de brillo utilizado en `main` es `8'h40`.

| Interruptores | Color | Valor GRB |
|---|---|---|
| `000` | Verde | `400000` |
| `001` | Rojo | `004000` |
| `010` | Azul | `000040` |
| `011` | Amarillo | `404000` |
| `100` | Cian | `400040` |
| `101` | Magenta | `004040` |
| `110` | Blanco | `404040` |
| `111` | Naranja | `104000` |

La entrada de los interruptores atraviesa dos etapas de sincronización. El registro `Color` se actualiza durante REINICIO y conserva su valor durante ENVÍO.

## Recepción y edición del texto

La comunicación UART utiliza bytes ASCII. Las letras mayúsculas y minúsculas se traducen al mismo código interno.

| Entrada | Código interno |
|---|---|
| `A`–`Z` o `a`–`z` | 0–25 |
| Espacio | 26 |
| `-` | 27 |
| `.` | 28 |
| `!` | 29 |
| `?` | 30 |
| `:` | 31 |
| `0`–`9` | 32–41 |
| `@` | 42, corazón |
| `(` | 43, carita feliz |
| `)` | 44, carita triste |
| `*` | 45, estrella |
| `~` | 46, nota musical |
| `>` | 47, flecha derecha |
| `<` | 48, flecha izquierda |
| `+` | 49, sol |

Los símbolos gráficos se seleccionan mediante los caracteres ASCII indicados en la tabla.

Cada carácter válido se incorpora por el extremo derecho del registro de frase y desplaza las posiciones anteriores hacia la izquierda. El registro conserva una capacidad fija de 32 caracteres.

Backspace, con código hexadecimal `08`, y Delete, con código `7F`, eliminan el carácter situado en el extremo derecho e introducen un espacio por el extremo izquierdo.

Los bytes que no tienen traducción ni corresponden a una operación de borrado conservan el contenido del registro. Por ejemplo, `#` se utiliza en los testbench para comprobar este comportamiento.

`uart_frase` actualiza el texto cuando recibe un byte válido, independientemente del valor de `Estado`.

## Herramientas

Para reproducir las simulaciones se utilizan:

- Icarus Verilog, mediante `iverilog` y `vvp`.
- GTKWave, para visualizar los archivos VCD.
- Una terminal Bash, por ejemplo Ubuntu o Ubuntu mediante WSL.

Los ejecutables de simulación incluidos en el repositorio fueron generados con Icarus Verilog 12.0.

Para consultar las herramientas instaladas:

```bash
iverilog -V
vvp -V
gtkwave --version
```

Los comandos de este documento se ejecutan desde la raíz de `Proyecto_ELDI`. Se deben respetar las mayúsculas de nombres como `Contadores.v`, `Mapeo_matriz.v` y `UART_frase.v`.

## Simulación integrada

Para ejecutar la prueba 3 de `main` y observar el pulso de un bit uno:

```bash
(
    set -e
    cd main

    iverilog -g2012 \
        -s tb_main \
        -Ptb_main.PRUEBA=3 \
        -o sim_main_3.vvp \
        main.v \
        tb_main.v \
        ../U_cont/Contadores.v \
        ../U_map/Mapeo_matriz.v \
        ../U_rom/rom_caracteres.v \
        ../U_scroll/desplazamiento.v \
        ../U_color/selector_color.v \
        ../U_frase/UART_frase.v \
        ../U_frase/uart_rx.v

    vvp sim_main_3.vvp
    gtkwave Main_3_bit_uno.vcd
)
```

El bloque regresa al directorio original al finalizar. Los archivos generados quedan dentro de `main/`.

### Pruebas de integración disponibles

| `PRUEBA` | Objeto de estudio | Archivo de ondas |
|---|---|---|
| 0 | Cuadro completo y reinicio posterior | `Main_0_cuadro.vcd` |
| 1 | Transición de REINICIO a ENVÍO | `Main_1_inicio.vcd` |
| 2 | Pulso correspondiente a un bit cero | `Main_2_bit_cero.vcd` |
| 3 | Pulso correspondiente a un bit uno | `Main_3_bit_uno.vcd` |
| 4 | Fin de cuadro y regreso a REINICIO | `Main_4_fin_cuadro.vcd` |
| 5 | Recepción UART durante el funcionamiento integrado | `Main_5_UART.vcd` |

El testbench integrado utiliza:

```verilog
defparam dut.u_scroll.Cuadros_por_paso = 1;
```

Este ajuste reduce el tiempo necesario para observar la entrada del texto. Las ventanas de simulación y las tablas correspondientes a `tb_main` consideran ese valor. En `main/main.v`, la configuración de funcionamiento utiliza 12 cuadros por paso.

## Reproducción de todas las pruebas finales

Los ocho testbench parametrizados reúnen 40 casos de prueba.

| Carpeta | Testbench | Valores de `PRUEBA` |
|---|---|---|
| `U_cont/` | `tb_contadores` | 0–6 |
| `U_map/` | `tb_mapeo_matriz` | 0–3 |
| `U_rom/` | `tb_rom_caracteres` | 0–6 |
| `U_scroll/` | `tb_desplazamiento` | 0–3 |
| `U_color/` | `tb_selector_color` | 0–2 |
| `U_frase/` | `tb_uart_rx` | 0–2 |
| `U_frase/` | `tb_uart_frase` | 0–5 |
| `main/` | `tb_main` | 0–5 |

El siguiente bloque compila y ejecuta los 40 casos. La función recibe la carpeta, el nombre del testbench, el último número de prueba y los archivos fuente.

```bash
(
    set -e

    simular() (
        set -e

        carpeta="$1"
        top="$2"
        ultima="$3"
        testbench="$4"
        shift 4

        cd "$carpeta"

        for ((prueba = 0; prueba <= ultima; prueba++)); do
            ejecutable="sim_${top}_${prueba}.vvp"

            iverilog -g2012 \
                -s "$top" \
                -P"${top}.PRUEBA=${prueba}" \
                -o "$ejecutable" \
                "$testbench" "$@"

            vvp "$ejecutable"
        done
    )

    simular U_cont tb_contadores 6 \
        tb_contadores.v Contadores.v

    simular U_map tb_mapeo_matriz 3 \
        tb_mapeo_matriz.v Mapeo_matriz.v

    simular U_rom tb_rom_caracteres 6 \
        tb_rom_caracteres.v rom_caracteres.v

    simular U_scroll tb_desplazamiento 3 \
        tb_desplazamiento.v desplazamiento.v

    simular U_color tb_selector_color 2 \
        tb_selector_color.v selector_color.v

    simular U_frase tb_uart_rx 2 \
        tb_uart_rx.v uart_rx.v

    simular U_frase tb_uart_frase 5 \
        tb_uart_frase.v UART_frase.v uart_rx.v

    simular main tb_main 5 \
        tb_main.v main.v \
        ../U_cont/Contadores.v \
        ../U_map/Mapeo_matriz.v \
        ../U_rom/rom_caracteres.v \
        ../U_scroll/desplazamiento.v \
        ../U_color/selector_color.v \
        ../U_frase/UART_frase.v \
        ../U_frase/uart_rx.v
)
```

Después de ejecutar las pruebas se pueden abrir las ondas seleccionadas:

```bash
gtkwave U_map/U_map_1_par_impar.vcd
gtkwave U_frase/U_frase_2_digitos.vcd
gtkwave main/Main_3_bit_uno.vcd
```

Los bancos de prueba aplican estímulos y generan las ondas para su análisis. La evaluación de los resultados se realiza mediante la comparación de las señales con las tablas y explicaciones de la documentación.

## Interpretación de las ondas

Los testbench utilizan:

```verilog
`timescale 1ns/1ps
```

Los retardos del código se expresan en nanosegundos y la precisión es de un picosegundo. Los VCD del repositorio emplean una escala de `1 ps`.

Por tanto:

- `1 ns = 1000 ps`.
- `10 ns = 10000 ps`.
- `250 ns = 250000 ps`.
- `880 ns = 880000 ps`.

Las ventanas registradas después del tiempo cero conservan los tiempos absolutos desde el inicio de la simulación.

En GTKWave, la integración principal se encuentra dentro de `tb_main.dut`. En las pruebas iniciales de `Tests/`, la instancia se denomina `uut`.

Los contadores e índices se interpretan en decimal, los colores y bytes ASCII en hexadecimal, y las banderas y señales de control en binario.

Los registros actualizados con asignaciones no bloqueantes utilizan los valores anteriores al flanco. En particular, `Datos_LED` refleja la comparación calculada a partir del contador y del bit existentes antes del flanco de subida.

## Pruebas iniciales

La carpeta `Tests/` conserva dos etapas iniciales del desarrollo:

1. Generación de una señal periódica para comprobar la salida de prueba.
2. Visualización de una letra A fija en un bloque de la matriz.

Los comandos, señales y resultados esperados se describen en [Tests/README.md](Tests/README.md).

Estas pruebas permiten estudiar por separado la generación de señales y la representación básica de un carácter antes de utilizar la arquitectura modular completa.

## Implementación en FPGA

Para llevar el diseño a hardware:

1. Crear un proyecto RTL en Vivado y seleccionar el dispositivo utilizado en el montaje.
2. Incorporar las ocho fuentes del diseño descritas en la arquitectura.
3. Seleccionar `main` como módulo superior.
4. Definir el reloj de entrada de 100 MHz.
5. Asignar los pines de `CLK`, `Interruptores`, `UART_RX` y `Datos_LED` según la tarjeta y las conexiones documentadas.
6. Ejecutar síntesis, implementación y generación del bitstream.
7. Programar la FPGA y realizar las comprobaciones físicas del montaje.

La reproducción en hardware requiere las restricciones correspondientes a la FPGA utilizada y las conexiones del montaje. La configuración de pines depende de la tarjeta.

El informe final describe el montaje, las decisiones de diseño y las pruebas físicas. Los archivos de simulación permiten reproducir el comportamiento lógico y temporal de las fuentes Verilog.

## Documentación

| Documento | Contenido |
|---|---|
| [Informe final](Documentacion/INFORME_FINAL.pdf) | Desarrollo del proyecto, arquitectura, implementación, montaje y conclusiones. |
| [Resultados de simulación](Documentacion/RESULTADOS_DE_SIMULACIÓN.pdf) | Casos de prueba, tablas de señales y análisis temporal. |
| [Ondas de simulación](Documentacion/Ondas/) | Capturas y explicaciones de los ocho módulos y bloques de estudio. |
| [Esquemáticos](Documentacion/esquematicos/) | Diagramas editables de `main`, `U_cont`, `U_map`, `U_rom`, `U_scroll`, `U_color`, `U_frase` y `U_rx`. |
| [Esquemáticos en SVG](Documentacion/esquematicos/formato%20svg/) | Versiones gráficas para consulta. |
| [Declaración de uso de IA](DECLARACION_DE_IA.md) | Alcance de la asistencia generativa y responsabilidades sobre el trabajo presentado. |

## Uso de inteligencia artificial

El proyecto incorporó asistencia de ChatGPT en actividades de programación, explicación del funcionamiento, preparación de testbench y documentación.

La participación identificable por módulo y las responsabilidades del estudiante se detallan en [DECLARACION_DE_IA.md](DECLARACION_DE_IA.md).