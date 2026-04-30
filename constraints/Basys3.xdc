## 100 MHz System Clock
set_property PACKAGE_PIN W5 [get_ports Clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports Clk_100MHz]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports Clk_100MHz]

## Reset — Centre Push Button (BTNC)
set_property PACKAGE_PIN U18 [get_ports Reset]
set_property IOSTANDARD LVCMOS33 [get_ports Reset]

## LEDs — LD0-LD3 = R7 result, LD13 = Overflow (bonus), LD14 = Zero, LD15 = Carry
set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
set_property PACKAGE_PIN V3  [get_ports {LED[9]}]
set_property PACKAGE_PIN W3  [get_ports {LED[10]}]
set_property PACKAGE_PIN U3  [get_ports {LED[11]}]
set_property PACKAGE_PIN P3  [get_ports {LED[12]}]
set_property PACKAGE_PIN N3  [get_ports {LED[13]}]
set_property PACKAGE_PIN P1  [get_ports {LED[14]}]
set_property PACKAGE_PIN L1  [get_ports {LED[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]

## 7-Segment Display Segments (active low)
set_property PACKAGE_PIN W7 [get_ports {Seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {Seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {Seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {Seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {Seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {Seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {Seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[*]}]

## 7-Segment Anodes (active low)
set_property PACKAGE_PIN U2 [get_ports {AN[0]}]
set_property PACKAGE_PIN U4 [get_ports {AN[1]}]
set_property PACKAGE_PIN V4 [get_ports {AN[2]}]
set_property PACKAGE_PIN W4 [get_ports {AN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[*]}]