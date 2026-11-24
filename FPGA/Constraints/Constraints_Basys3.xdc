## Reloj de 100 MHz
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports CLK]
create_clock -period 10.000 -name sys_clk [get_ports CLK]

## Switches 
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {Interruptores[0]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {Interruptores[1]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {Interruptores[2]}]

## UART RX 
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports UART_RX]

## JA1
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports Datos_LED]