# Pruebas iniciales del proyecto

Esta carpeta conserva las pruebas utilizadas durante las primeras etapas del desarrollo. Su propósito es estudiar la generación de señales de salida y la representación de una letra fija antes de integrar los módulos del controlador final.

## Contenido

| Carpeta | Fuente | Testbench | Módulo bajo prueba |
|---|---|---|---|
| `test_integrado/` | `testeo_led.v` | `tb_testeo_led.v` | `test_74HCT245` |
| `testeo_letra_funcional/` | `testeo_letraA.v` | `tb_testeoA.v` | `ws2812_fastled` |

Las pruebas se ejecutan con Icarus Verilog y sus resultados se visualizan mediante GTKWave.

Todos los comandos siguientes parten de la raíz del repositorio.

## Prueba de señal periódica

### Objetivo

Generar una señal digital periódica en `TEST_OUT` para observar la salida de prueba y apoyar la comprobación física de la cadena de conexión del montaje.

El módulo utiliza un contador y un registro de estado. Cuando el contador alcanza `MAX_COUNT`, se reinicia y cambia el estado de la salida.

### Parámetros

| Configuración | `MAX_COUNT` | Intervalo entre cambios de salida a 100 MHz |
|---|---:|---:|
| Valor predeterminado del módulo | 49999999 | 0,5 s |
| Valor utilizado por el testbench | 4 | 50 ns |

Con el valor predeterminado, el período completo de la salida es de un segundo. En el testbench, el período completo es de 100 ns.

El testbench mantiene la simulación durante 200 ns.

### Ejecución

```bash
(
    set -e
    cd Tests/test_integrado

    iverilog -g2012 \
        -s tb_test_74HCT245 \
        -o sim.vvp \
        testeo_led.v \
        tb_testeo_led.v

    vvp sim.vvp
    gtkwave simulacion.vcd
)
```

### Señales y resultados esperados

La jerarquía principal es `tb_test_74HCT245`, con la instancia `uut`.

| Señal | Interpretación |
|---|---|
| `clk` | Reloj de 100 MHz. |
| `uut.contador` | Cuenta desde 0 hasta 4. |
| `uut.estado` | Cambia cuando el contador alcanza el valor límite. |
| `TEST_OUT` | Reproduce el valor del registro `estado`. |

La salida comienza en cero. Con el reloj del testbench, sus cambios aparecen a los 45, 95, 145 y 195 ns. La separación entre cambios consecutivos es de 50 ns.

La simulación representa el comportamiento del generador digital. Los niveles eléctricos y la propagación del adaptador del montaje se comprueban mediante mediciones físicas.

## Prueba de la letra A

### Objetivo

Representar una letra A fija en un bloque de 8 × 8 píxeles de la matriz de 8 × 32.

El módulo reúne en una implementación inicial:

- La temporización de la señal serial.
- El recorrido de los 256 píxeles.
- El mapeo por columnas en zigzag.
- El patrón de la letra A.
- La selección de un bloque de ocho columnas.
- La serialización del color de cada píxel.

### Parámetros principales

| Parámetro | Valor |
|---|---|
| `T0H` | 25 ciclos |
| `T1H` | 88 ciclos |
| `BIT_PERIOD` | 125 ciclos |
| `RESET_TIME` | 28000 ciclos |
| `BLOCK` | 0 |
| `COLOR` | `24'h001000` |

Con un reloj de 100 MHz, los tiempos corresponden a 250 ns de nivel alto para un bit cero, 880 ns para un bit uno y 1,25 µs por bit.

`BLOCK = 0` selecciona las columnas 0 a 7.

El valor actual `COLOR = 24'h001000` corresponde a rojo tenue en orden GRB, con los componentes `G = 00`, `R = 10` y `B = 00`.

El testbench simula 9000000 ns, equivalentes a 9 ms, para incluir un cuadro completo y el comienzo del siguiente ciclo.

### Ejecución

```bash
(
    set -e
    cd Tests/testeo_letra_funcional

    iverilog -g2012 \
        -s tb_testeoA \
        -o simLetra_A.vvp \
        testeo_letraA.v \
        tb_testeoA.v

    vvp simLetra_A.vvp
    gtkwave Letra_A.vcd
)
```

### Señales y resultados esperados

La simulación regenerada utiliza la jerarquía `tb_testeoA.uut`.

| Señal | Interpretación |
|---|---|
| `clk` | Reloj de 100 MHz. |
| `uut.state` | Estado de reinicio o transmisión. |
| `uut.reset_counter` | Conteo del intervalo de reinicio. |
| `uut.bit_counter` | Posición temporal dentro de un bit. |
| `uut.bit_index` | Selección del bit de color, desde 23 hasta 0. |
| `uut.pixel_index` | Índice del píxel, desde 0 hasta 255. |
| `uut.col` y `uut.row` | Coordenadas del píxel considerando el zigzag. |
| `uut.font_row` | Patrón de ocho bits de la fila de la letra A. |
| `uut.in_block` | Indica si el píxel pertenece al bloque seleccionado. |
| `uut.pixel_on` | Selección del píxel encendido. |
| `uut.pixel_color` | Color transmitido para el píxel. |
| `uut.current_bit` | Bit de color seleccionado. |
| `led_data` | Salida serial registrada. |

Durante el reinicio, `led_data` permanece en cero. Durante la transmisión, se generan los pulsos correspondientes a los 24 bits de cada píxel.

Los píxeles del patrón de la letra A reciben el valor `COLOR`. Los demás reciben `24'h000000`, transmitido mediante 24 bits cero con sus respectivos pulsos.

El VCD histórico incluido puede mostrar la jerarquía `tb_ws2812_fastled`. Al regenerarlo con los archivos actuales, la jerarquía corresponde a `tb_testeoA`.

## Visualización de las ondas

Los testbench utilizan una unidad de tiempo de 1 ns y una precisión de 1 ps.

| Magnitud | Equivalencia |
|---|---|
| 1 ns | 1000 ps |
| 10 ns | 10000 ps |
| 200 ns | 200000 ps |
| 9 ms | 9000000000 ps |

Para interpretar las señales:

- Mostrar contadores e índices en decimal.
- Mostrar los colores de 24 bits en hexadecimal.
- Mostrar patrones de píxeles en binario.
- Mostrar estados de un bit y banderas en binario.

Los registros se actualizan en los flancos de subida del reloj. En la salida serial, las condiciones utilizadas para calcular el nuevo valor corresponden al estado previo a ese flanco.

## Relación con el diseño final

Estas pruebas documentan etapas iniciales de la construcción del controlador.

El diseño final distribuye las funciones de la prueba de letra fija entre los módulos `contadores`, `mapeo_matriz`, `rom_caracteres`, `desplazamiento`, `selector_color`, `uart_rx`, `uart_frase` y `main`.

La versión integrada incorpora desplazamiento del texto, selección de colores y edición mediante UART.

La reproducción de las pruebas finales y la documentación general se encuentran en el [README principal](../README.md).