v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
B 2 420 -1100 1820 -600 {flags=graph
y1=0
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=7e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
digital=0
rainbow=1

color="5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 4 5 6 7"
node="x1.w_dly_sig[21]
x1.w_dly_sig[20]
x1.w_dly_sig[19]
x1.w_dly_sig[18]
x1.w_dly_sig[17]
x1.w_dly_sig[16]
x1.w_dly_sig[15]
x1.w_dly_sig[14]
x1.w_dly_sig[13]
x1.w_dly_sig[12]
x1.w_dly_sig[11]
x1.w_dly_sig[10]
x1.w_dly_sig[9]
x1.w_dly_sig[8]
x1.w_dly_sig[7]
x1.w_dly_sig[6]
x1.w_dly_sig[5]
x1.w_dly_sig[4]
x1.w_dly_sig[3]
x1.w_dly_sig[2]
x1.w_dly_sig[1]"}
B 2 420 -1590 1820 -1160 {flags=graph
y1=0
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=7e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
digital=1

color="7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7"
node="res[0]
res[1]
res[2]
res[3]
res[4]
res[5]
res[6]
res[7]
res[8]
res[9]
res[10]
res[11]
res[12]
res[13]
res[14]
res[15]
res[16]
res[17]
res[18]
res[19]
res[20]
res[21]
res[22]
res[23]
res[24]
res[25]
res[26]
res[27]
res[28]
res[29]
res[30]
res[31]
res[32]
res[33]
res[34]
res[35]
res[36]
res[37]
res[38]
res[39]
res[40]
res[41]
res[42]
res[43]
res[44]
res[45]
res[46]
res[47]
res[48]
res[49]
res[50]
res[51]
res[52]
res[53]
res[54]
res[55]
res[56]
res[57]
res[58]
res[59]
res[60]
res[61]
res[62]
res[63]
res[64]
res[65]"}
N 340 -140 340 -120 {
lab=GND}
N 1330 -360 1330 -340 {
lab=GND}
N 340 -220 340 -200 {
lab=VDD}
N 640 -320 640 -310 {
lab=GND}
N 840 -310 840 -300 {
lab=GND}
N 840 -400 1130 -400 {
lab=stop}
N 840 -400 840 -370 {
lab=stop}
N 1580 -280 1580 -240 {
lab=GND}
N 1510 -420 1580 -420 {
lab=res[65:0]}
N 1580 -420 1580 -340 {
lab=res[65:0]}
N 640 -420 1130 -420 {
lab=start}
N 640 -420 640 -380 {
lab=start}
N 1330 -500 1330 -460 {
lab=VDD}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Harald Pretl, IIC @ JKU"}
C {devices/vdd.sym} 340 -220 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 340 -120 0 0 {name=l3 lab=GND}
C {devices/simulator_commands.sym} 210 -570 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
* ngspice commands
****************

.save v(x1.w_dly_sig[0])
.save v(x1.w_dly_sig[1])
.save v(x1.w_dly_sig[2])
.save v(x1.w_dly_sig[3])
.save v(x1.w_dly_sig[4])
.save v(x1.w_dly_sig[5])
.save v(x1.w_dly_sig[6])
.save v(x1.w_dly_sig[7])
.save v(x1.w_dly_sig[8])
.save v(x1.w_dly_sig[9])
.save v(x1.w_dly_sig[10])
.save v(x1.w_dly_sig[11])
.save v(x1.w_dly_sig[12])
.save v(x1.w_dly_sig[13])
.save v(x1.w_dly_sig[14])
.save v(x1.w_dly_sig[15])
.save v(x1.w_dly_sig[16])
.save v(x1.w_dly_sig[17])
.save v(x1.w_dly_sig[18])
.save v(x1.w_dly_sig[19])
.save v(x1.w_dly_sig[20])
.save v(x1.w_dly_sig[21])

****************
* Misc
****************
.param fclk=10MEG
.options method=gear maxord=2
.temp 30

.control
set num_threads=6
tran 0.01n 600n

write tb_tt06_tdc.raw

*exit
.endc
"}
C {tdc.sym} 1150 -380 0 0 {name=x1}
C {devices/gnd.sym} 1330 -340 0 0 {name=l8 lab=GND}
C {devices/vdd.sym} 1330 -500 0 0 {name=l9 lab=VDD}
C {devices/vsource.sym} 640 -350 0 0 {name=VDAC value="0 pwl(0 0 500n 0 500.1n 1.8)"}
C {devices/gnd.sym} 640 -310 0 0 {name=l10 lab=GND}
C {devices/spice_probe.sym} 640 -420 0 0 {name=p1 attrs=""}
C {devices/vsource.sym} 840 -340 0 0 {name=VDAC1 value="0 pwl(0 0 508n 0 508.1n 1.8)"}
C {devices/gnd.sym} 840 -300 0 0 {name=l13 lab=GND}
C {devices/spice_probe.sym} 840 -400 0 0 {name=p2 attrs=""}
C {devices/lab_wire.sym} 900 -400 0 1 {name=l14 sig_type=std_logic lab=stop}
C {devices/code.sym} 210 -750 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
spice_ignore=false}
C {devices/capa.sym} 1580 -310 0 0 {name=Cload[65:0]
m=1
value=10f}
C {devices/gnd.sym} 1580 -240 0 0 {name=l15 lab=GND}
C {devices/lab_wire.sym} 1540 -420 0 1 {name=l16 sig_type=std_logic lab=res[65:0]}
C {devices/spice_probe.sym} 1580 -380 0 0 {name=p3 attrs=""}
C {devices/lab_wire.sym} 900 -420 0 1 {name=l4 sig_type=std_logic lab=start}
C {devices/launcher.sym} 300 -320 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_tt06_tdc.raw tran"
}
C {devices/spice_probe.sym} 340 -210 0 0 {name=p4 attrs=""}
C {devices/vsource.sym} 340 -170 0 0 {name=VDAC2 value="0 pwl(0 0 100n 1.8)"}
C {devices/launcher.sym} 300 -380 0 0 {name=h2 
descr="simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"}
