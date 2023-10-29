
if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "Registradora.vhd"
vcom -explicit  -93 "tb_Registradora.vhd"
vsim -t 1ns   -lib work tb_Registradora
add wave sim:/tb_Registradora/*
#do {wave.do}
view wave
view structure
view signals
run 200ns
#quit -force

