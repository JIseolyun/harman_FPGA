
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2$
create_project: 2default:default2
00:00:062default:default2
00:00:062default:default2
429.8202default:default2
94.0202default:defaultZ17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/utils_1/imports/synth_1/top_sensor.dcp2default:defaultZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2�
lC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/utils_1/imports/synth_1/top_sensor.dcp2default:defaultZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
t
Command: %s
53*	vivadotcl2C
/synth_design -top top_all -part xc7a35tcpg236-12default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-349h px� 
V
Loading part %s157*device2#
xc7a35tcpg236-12default:defaultZ21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
�
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
_
#Helper process launched with PID %s4824*oasys2
50002default:defaultZ8-7075h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
REGCCE2default:default2
wire2default:default2[
EC:/Xilinx/Vivado/2022.2/data/verilog/src/unimacro/BRAM_SINGLE_MACRO.v2default:default2
21702default:default8@Z8-11241h px� 
�
%s*synth2�
yStarting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:04 . Memory (MB): peak = 1238.117 ; gain = 408.891
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
top_all2default:default2
 2default:default2s
]C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/top_all.v2default:default2
32default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_fsm2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
42default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_tx2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
2082default:default8@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
2502default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_tx2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
2082default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_rx2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
862default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_rx2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
862default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
tick_9600hz2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
3052default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
tick_9600hz2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
3052default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
fifo2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
3462default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2!
register_file2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
3822default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
register_file2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
3822default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
fifo_cu2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
4032default:default8@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
4402default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
fifo_cu2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
4032default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
fifo2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
3462default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	data_save2default:default2
 2default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
1792default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	data_save2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
1792default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_cu2default:default2
 2default:default2s
]C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_cu.v2default:default2
622default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_cu2default:default2
 2default:default2
02default:default2
12default:default2s
]C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_cu.v2default:default2
622default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_fsm2default:default2
 2default:default2
02default:default2
12default:default2t
^C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_fsm.v2default:default2
42default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

top_sensor2default:default2
 2default:default2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
32default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	sensor_cu2default:default2
 2default:default2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
482default:default8@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
872default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	sensor_cu2default:default2
 2default:default2
02default:default2
12default:default2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
482default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2 
btn_debounce2default:default2
 2default:default2�
C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/imports/Source/btn_debounce.v2default:default2
32default:default8@Z8-6157h px� 
�
8referenced signal '%s' should be on the sensitivity list567*oasys2
q_reg2default:default2�
C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/imports/Source/btn_debounce.v2default:default2
252default:default8@Z8-567h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2 
btn_debounce2default:default2
 2default:default2
02default:default2
12default:default2�
C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/imports/Source/btn_debounce.v2default:default2
32default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
tick_1us2default:default2
 2default:default2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
1312default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
tick_1us2default:default2
 2default:default2
02default:default2
12default:default2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
1312default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2"
fnd_controller2default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
32default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	clock_div2default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
732default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	clock_div2default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
732default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	counter_42default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
562default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	counter_42default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
562default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
decoder_2x42default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
962default:default8@Z8-6157h px� 
�
default block is never used226*oasys2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1012default:default8@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
decoder_2x42default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
962default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2"
digit_splitter2default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1112default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2"
digit_splitter2default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1112default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
mux_4x12default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1252default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mux_4x12default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1252default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
bcdtoseg2default:default2
 2default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1472default:default8@Z8-6157h px� 
�
default block is never used226*oasys2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1522default:default8@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
bcdtoseg2default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
1472default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2"
fnd_controller2default:default2
 2default:default2
02default:default2
12default:default2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/fnd_controller.v2default:default2
32default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

top_sensor2default:default2
 2default:default2
02default:default2
12default:default2�
rC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/imports/sources_1/new/top_sensor.v2default:default2
32default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top_all2default:default2
 2default:default2
02default:default2
12default:default2s
]C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/top_all.v2default:default2
32default:default8@Z8-6155h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2'
trigger_counter_reg2default:default2s
]C:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/sources_1/new/uart_cu.v2default:default2
842default:default8@Z8-6014h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	btn_start2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[7]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[6]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[5]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[4]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[3]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[2]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[1]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
tx_data_in[0]2default:default2
uart_fsm2default:defaultZ8-7129h px� 
�
%s*synth2�
yFinished RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:05 . Memory (MB): peak = 1332.457 ; gain = 503.230
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:04 ; elapsed = 00:00:05 . Memory (MB): peak = 1332.457 ; gain = 503.230
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:04 ; elapsed = 00:00:05 . Memory (MB): peak = 1332.457 ; gain = 503.230
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0022default:default2
1332.4572default:default2
0.0002default:defaultZ17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/constrs_1/imports/FPGA_Harman/Basys-3-Master.xdc2default:default8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/constrs_1/imports/FPGA_Harman/Basys-3-Master.xdc2default:default8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
vC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.srcs/constrs_1/imports/FPGA_Harman/Basys-3-Master.xdc2default:default2-
.Xil/top_all_propImpl.xdc2default:defaultZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1437.0702default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0032default:default2
1437.0702default:default2
0.0002default:defaultZ17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
REGCCE2default:default2
wire2default:default2[
EC:/Xilinx/Vivado/2022.2/data/verilog/src/unimacro/BRAM_SINGLE_MACRO.v2default:default2
21702default:default8@Z8-11241h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:09 ; elapsed = 00:00:11 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Loading part: xc7a35tcpg236-1
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:09 ; elapsed = 00:00:11 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:09 ; elapsed = 00:00:11 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2default:default2
uart_tx2default:defaultZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2default:default2
uart_rx2default:defaultZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2default:default2
uart_cu2default:defaultZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2default:default2
	sensor_cu2default:defaultZ8-802h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                  R_IDLE |                               00 |                             0000
2default:defaulth p
x
� 
�
%s
*synth2s
_                   START |                               01 |                             0001
2default:defaulth p
x
� 
�
%s
*synth2s
_              DATA_STATE |                               10 |                             0010
2default:defaulth p
x
� 
�
%s
*synth2s
_                    STOP |                               11 |                             0011
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2default:default2

sequential2default:default2
uart_tx2default:defaultZ8-3354h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                  R_IDLE |                               00 |                               00
2default:defaulth p
x
� 
�
%s
*synth2s
_                   START |                               01 |                               01
2default:defaulth p
x
� 
�
%s
*synth2s
_              DATA_STATE |                               10 |                               10
2default:defaulth p
x
� 
�
%s
*synth2s
_                    STOP |                               11 |                               11
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2default:default2

sequential2default:default2
uart_rx2default:defaultZ8-3354h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                  S_IDLE |                               00 |                               00
2default:defaulth p
x
� 
�
%s
*synth2s
_                 S_CHECK |                               01 |                               01
2default:defaulth p
x
� 
�
%s
*synth2s
_               S_TRIGGER |                               10 |                               10
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2default:default2

sequential2default:default2
uart_cu2default:defaultZ8-3354h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                              000 |                             0000
2default:defaulth p
x
� 
�
%s
*synth2s
_                   START |                              001 |                             0001
2default:defaulth p
x
� 
�
%s
*synth2s
_                    WAIT |                              010 |                             0010
2default:defaulth p
x
� 
�
%s
*synth2s
_                    DATA |                              011 |                             0011
2default:defaulth p
x
� 
�
%s
*synth2s
_                  iSTATE |                              100 |                             1111
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2default:default2

sequential2default:default2
	sensor_cu2default:defaultZ8-3354h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   18 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   17 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   16 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   10 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    7 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    6 Bit       Adders := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    5 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    4 Bit       Adders := 12    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit       Adders := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               18 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               17 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               16 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               10 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                8 Bit    Registers := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                7 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                6 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                4 Bit    Registers := 7     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                2 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 12    
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   18 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   17 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input   16 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    8 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    6 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    5 Bit        Muxes := 3     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    5 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    4 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    4 Bit        Muxes := 3     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    3 Bit        Muxes := 3     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    2 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 5     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    1 Bit        Muxes := 22    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    1 Bit        Muxes := 3     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    1 Bit        Muxes := 4     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2j
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2G
3U_TOP_SENSOR/U_senor_cu/FSM_sequential_state_reg[2]2default:default2
top_all2default:defaultZ8-3332h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
j
%s*synth2R
>
Distributed RAM: Preliminary Mapping Report (see note below)
2default:defaulth px� 
�
%s*synth2w
c+------------+----------------------------------+-----------+----------------------+-------------+
2default:defaulth px� 
�
%s*synth2x
d|Module Name | RTL Object                       | Inference | Size (Depth x Width) | Primitives  | 
2default:defaulth px� 
�
%s*synth2w
c+------------+----------------------------------+-----------+----------------------+-------------+
2default:defaulth px� 
�
%s*synth2x
d|top_all     | U_UART/FIFO_RX/uregister/ram_reg | Implied   | 16 x 8               | RAM32M x 2  | 
2default:defaulth px� 
�
%s*synth2x
d|top_all     | U_UART/FIFO_TX/uregister/ram_reg | Implied   | 16 x 8               | RAM32M x 2  | 
2default:defaulth px� 
�
%s*synth2x
d+------------+----------------------------------+-----------+----------------------+-------------+

2default:defaulth px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the Distributed RAMs at the current stage of the synthesis flow. Some Distributed RAMs may be reimplemented as non Distributed RAM primitives later in the synthesis flow. Multiple instantiated RAMs are reported only once.
2default:defaulth px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
}Finished Timing Optimization : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
S
%s
*synth2;
'
Distributed RAM: Final Mapping Report
2default:defaulth p
x
� 
�
%s
*synth2w
c+------------+----------------------------------+-----------+----------------------+-------------+
2default:defaulth p
x
� 
�
%s
*synth2x
d|Module Name | RTL Object                       | Inference | Size (Depth x Width) | Primitives  | 
2default:defaulth p
x
� 
�
%s
*synth2w
c+------------+----------------------------------+-----------+----------------------+-------------+
2default:defaulth p
x
� 
�
%s
*synth2x
d|top_all     | U_UART/FIFO_RX/uregister/ram_reg | Implied   | 16 x 8               | RAM32M x 2  | 
2default:defaulth p
x
� 
�
%s
*synth2x
d|top_all     | U_UART/FIFO_TX/uregister/ram_reg | Implied   | 16 x 8               | RAM32M x 2  | 
2default:defaulth p
x
� 
�
%s
*synth2x
d+------------+----------------------------------+-----------+----------------------+-------------+

2default:defaulth p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Technology Mapping : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
vFinished IO Insertion : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
F
%s*synth2.
+------+---------+------+
2default:defaulth px� 
F
%s*synth2.
|      |Cell     |Count |
2default:defaulth px� 
F
%s*synth2.
+------+---------+------+
2default:defaulth px� 
F
%s*synth2.
|1     |BUFG     |     1|
2default:defaulth px� 
F
%s*synth2.
|2     |CARRY4   |    60|
2default:defaulth px� 
F
%s*synth2.
|3     |LUT1     |    22|
2default:defaulth px� 
F
%s*synth2.
|4     |LUT2     |   154|
2default:defaulth px� 
F
%s*synth2.
|5     |LUT3     |    86|
2default:defaulth px� 
F
%s*synth2.
|6     |LUT4     |   104|
2default:defaulth px� 
F
%s*synth2.
|7     |LUT5     |    62|
2default:defaulth px� 
F
%s*synth2.
|8     |LUT6     |   128|
2default:defaulth px� 
F
%s*synth2.
|9     |RAM32M   |     2|
2default:defaulth px� 
F
%s*synth2.
|10    |RAM32X1D |     4|
2default:defaulth px� 
F
%s*synth2.
|11    |FDCE     |   143|
2default:defaulth px� 
F
%s*synth2.
|12    |FDPE     |     2|
2default:defaulth px� 
F
%s*synth2.
|13    |FDRE     |     8|
2default:defaulth px� 
F
%s*synth2.
|14    |IBUF     |     5|
2default:defaulth px� 
F
%s*synth2.
|15    |OBUF     |    14|
2default:defaulth px� 
F
%s*synth2.
+------+---------+------+
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 2 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:17 ; elapsed = 00:00:23 . Memory (MB): peak = 1437.070 ; gain = 503.230
2default:defaulth p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1437.070 ; gain = 607.844
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0052default:default2
1437.0702default:default2
0.0002default:defaultZ17-268h px� 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
662default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1437.0702default:default2
0.0002default:defaultZ17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2�
�  A total of 6 instances were transformed.
  RAM32M => RAM32M (RAMD32(x6), RAMS32(x2)): 2 instances
  RAM32X1D => RAM32X1D (RAMD32(x2)): 4 instances
2default:defaultZ1-111h px� 
g
$Synth Design complete, checksum: %s
562*	vivadotcl2
2f003e822default:defaultZ4-1430h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
782default:default2
132default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:262default:default2
00:00:282default:default2
1437.0702default:default2
983.3752default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2m
YC:/working_verilog/harman_FPGA/project3_sensor1/project3_sensor1.runs/synth_1/top_all.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2x
dExecuting : report_utilization -file top_all_utilization_synth.rpt -pb top_all_utilization_synth.pb
2default:defaulth px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Wed Mar 26 23:49:32 20252default:defaultZ17-206h px� 


End Record