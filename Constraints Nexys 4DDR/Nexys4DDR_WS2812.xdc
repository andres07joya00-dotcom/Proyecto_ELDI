## Clock: 100 MHz
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {CLK}]
create_clock -name sys_clk -period 10.000 -waveform {0.000 5.000} [get_ports {CLK}]


set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {Interruptores[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {Interruptores[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {Interruptores[2]}]


set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {UART_RX}]


set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {Datos_LED}]
