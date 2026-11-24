# Declaración de uso de inteligencia artificial

Durante el desarrollo de este proyecto usamos ChatGPT como apoyo para trabajar el código en Verilog, entender el funcionamiento de los módulos, preparar las simulaciones y organizar la documentación.

Somos dos estudiantes y, como equipo, nos encargamos de definir las funciones del proyecto, integrar sus componentes, ejecutar las herramientas y preparar las evidencias que presentamos. La IA tuvo una participación importante en la generación de código de apoyo, los bancos de prueba y los primeros borradores de varios textos.

La usamos porque, durante el desarrollo, surgieron dudas sobre cómo relacionar el código con el hardware, cómo interpretar las actualizaciones de los registros y cómo comprobar el comportamiento de cada módulo. También nos permitió preparar más casos de simulación y organizar el análisis de las ondas.

## Cómo trabajamos con la IA

Compartimos versiones de los módulos, esquemáticos y capturas de las simulaciones. A partir de ese material pedimos explicaciones, propuestas de modificación y pruebas que nos ayudaran a estudiar el comportamiento del circuito.

El proceso tuvo varias revisiones. Por ejemplo, pedimos simplificar los primeros testbench, separar las simulaciones por partes y seleccionar intervalos de tiempo que permitieran observar mejor las señales. También consultamos cómo agrupar los buses y cómo comparar las ondas con las tablas de resultados.

Las propuestas de la IA se incorporaron al trabajo del equipo mediante su selección, adaptación e integración. Reconocemos que algunas partes fueron generadas directamente por esta herramienta y que eso debe quedar indicado en la declaración.

## Participación por módulo

### Módulo principal (`main`)

Usamos la IA para revisar la conexión entre los módulos y entender cómo se obtiene el píxel que debe mostrarse, cómo se selecciona su color y cómo se genera la salida serial.

También generó el testbench integrado y propuso las ventanas de tiempo para observar el inicio del envío, la duración de los pulsos, el fin del cuadro y la recepción UART. Nosotros aportamos la versión del módulo, la incorporamos al proyecto y trabajamos con las señales obtenidas en la simulación.

### Contadores (`U_cont`)

Nos ayudó a analizar los contadores, sus banderas y las actualizaciones que ocurren en los flancos de reloj. Este apoyo fue especialmente útil para estudiar por qué una bandera se activa antes de que el registro capture su siguiente valor.

A partir del código compartido, la IA generó pruebas de reinicio, avance de bits y píxeles, cambio de columna, fin de cuadro e interrupción del envío. Nosotros ejecutamos las simulaciones y revisamos sus secuencias temporales.

### Mapeo de la matriz (`U_map`)

Recibimos ayuda para explicar el recorrido en zigzag y la inversión de las filas en las columnas impares.

La IA preparó el testbench por intervalos y calculó las coordenadas esperadas. Nosotros trabajamos en el esquemático, la selección de señales y las capturas utilizadas para mostrar los cambios entre columnas y las posiciones finales de la matriz.

### ROM de caracteres (`U_rom`)

Pedimos ayuda para generar y ampliar los patrones de letras, números, signos y símbolos gráficos. Por esta razón, reconocemos una participación importante de la IA en el código del banco de caracteres.

También recibimos apoyo para revisar la codificación de seis bits y generar pruebas que recorrieran los caracteres y sus ocho filas. Como equipo definimos los caracteres requeridos, integramos la ROM y revisamos su relación con el desplazamiento y la selección del píxel.

### Desplazamiento (`U_scroll`)

Usamos la IA para estudiar la función de los registros de inicio y de los registros que recorren las columnas del cuadro. Consultamos sobre el espacio entre caracteres, el relleno inicial y el avance después de varios cuadros.

La IA generó pruebas para observar esos comportamientos, incluyendo la entrada del texto y su regreso al inicio. Nosotros aportamos versiones del módulo y del esquemático, y trabajamos en la interpretación de los índices y subcolumnas.

### Selector de color (`U_color`)

Nos apoyamos en la IA para revisar el formato GRB, las dos etapas de sincronización de los interruptores y la actualización del color durante el reinicio.

También generó pruebas para los ocho colores y para observar cómo se conserva el valor durante el envío. Nosotros incorporamos el módulo y revisamos la correspondencia entre los interruptores y los valores de salida.

### Receptor UART (`uart_rx`)

Compartimos el receptor utilizado y pedimos ayuda para entender su máquina de estados, la sincronización de la entrada y los puntos de muestreo.

La IA generó pruebas de recepción de bytes, de un pulso de inicio breve y de bytes consecutivos. Nosotros integramos el receptor con el registro de frase y ejecutamos las simulaciones correspondientes.

### Registro de frase (`uart_frase`)

Recibimos apoyo para revisar la traducción de ASCII a los códigos de la ROM y las operaciones de inserción y borrado.

La IA preparó pruebas de letras, dígitos, signos, símbolos gráficos, Backspace, Delete y caracteres ignorados. Nosotros definimos las funciones de edición que necesitábamos, incorporamos el módulo y revisamos los cambios del registro de frase.

### Pruebas iniciales

También utilizamos sus explicaciones para documentar la generación de una señal periódica y la visualización de una letra A fija.

Estas pruebas forman parte de las primeras etapas del proyecto. El historial disponible permite identificar la asistencia recibida para explicarlas y documentarlas, aunque la autoría inicial de cada línea de esas versiones queda sin una atribución completa.

## Bancos de prueba y revisión de resultados

Los ocho testbench parametrizados de la arquitectura final fueron redactados sustancialmente con ayuda de la IA, a partir de nuestros módulos y de los casos que le fuimos solicitando.

Esto incluye la generación del reloj, las tareas para transmitir bytes UART, el parámetro `PRUEBA`, las ventanas temporales y los nombres de los archivos de ondas. La organización por casos permitió estudiar cada comportamiento con mayor detalle.

Nosotros incorporamos esos archivos al repositorio, ejecutamos las simulaciones y utilizamos GTKWave para seleccionar las señales, agrupar los buses y obtener las capturas.

Durante el análisis consultamos dudas sobre las unidades de tiempo, los valores posteriores a cada flanco y las diferencias entre las señales combinacionales y registradas. Estas consultas también ayudaron a revisar la presentación de los resultados.

Parte de las tablas se calculó mediante el análisis del código y de sus tiempos, porque la IA no pudo ejecutar directamente Icarus Verilog durante esas sesiones. Esos valores se utilizaron como referencia para comparar las ondas. La ejecución de las simulaciones y las capturas corresponde al trabajo realizado en nuestro entorno.

## Esquemáticos y documentación

La IA nos ayudó a relacionar el código con registros, comparadores, multiplexores y conexiones. Como equipo trabajamos en la elaboración, revisión y organización de los esquemáticos.

También generó borradores de las tablas, las notas de las gráficas, las conclusiones, los README y esta declaración. Su aporte en la redacción inicial de la documentación fue considerable.

Las capturas que compartimos se utilizaron para acompañar las explicaciones. La interpretación de esas capturas y su correspondencia con las fuentes forman parte de nuestra revisión del proyecto.

## Valoración del aporte y responsabilidad

Consideramos que la IA tuvo una participación alta en los testbench, en la ampliación de la ROM y en la redacción inicial de la documentación. En los demás módulos, su participación identificable incluyó explicaciones, propuestas y revisiones del funcionamiento.

Nuestra participación fue central en la dirección del proyecto, la integración de los componentes, el trabajo con las herramientas, la ejecución de simulaciones y la preparación de las evidencias.

Preferimos detallar las tareas realizadas y también reconocemos que recibir una explicación o una propuesta de código exige estudiarla y contrastarla con el comportamiento del circuito.

Como autores del proyecto, asumimos la responsabilidad de revisar lo que incorporamos, comprender el diseño y sustentar los resultados presentados. Las pruebas físicas que se reportan en el informe corresponden al trabajo realizado por nuestro equipo.