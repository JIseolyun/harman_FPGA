
j
Command: %s
53*	vivadotcl29
%write_bitstream -force calculator.bit2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px� 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�	
�Unspecified I/O Standard: 8 out of 31 logical ports use I/O standard (IOSTANDARD) value 'DEFAULT', instead of a user assigned specific value. This may cause I/O contention or incompatibility with the board power or connectivity affecting performance, signal integrity or in extreme cases cause damage to the device or the components to which it is connected. To correct this violation, specify all I/O standards. This design will fail to generate a bitstream unless all logical ports have a user specified I/O standard value defined. To allow bitstream creation with unspecified I/O standard values (not recommended), use this command: set_property SEVERITY {Warning} [get_drc_checks NSTD-1].  NOTE: When using the Vivado Runs infrastructure (e.g. launch_runs Tcl command), add this command to a .tcl file and add that file as a pre-hook for write_bitstream step for the implementation run. Problem ports: %s.%s*DRC2�
 " 
a[7]a[7]2default:default" 
a[6]a[6]2default:default" 
a[5]a[5]2default:default" 
a[4]a[4]2default:default" 
b[7]b[7]2default:default" 
b[6]b[6]2default:default" 
b[5]b[5]2default:default" 
b[4]b[4]2default:default2default:default2(
 DRC|Pin Planning2default:default8ZNSTD-1h px� 
�	
�Unconstrained Logical Port: 8 out of 31 logical ports have no user assigned specific location constraint (LOC). This may cause I/O contention or incompatibility with the board power or connectivity affecting performance, signal integrity or in extreme cases cause damage to the device or the components to which it is connected. To correct this violation, specify all pin locations. This design will fail to generate a bitstream unless all logical ports have a user specified site LOC constraint defined.  To allow bitstream creation with unspecified pin locations (not recommended), use this command: set_property SEVERITY {Warning} [get_drc_checks UCIO-1].  NOTE: When using the Vivado Runs infrastructure (e.g. launch_runs Tcl command), add this command to a .tcl file and add that file as a pre-hook for write_bitstream step for the implementation run.  Problem ports: %s.%s*DRC2�
 " 
a[7]a[7]2default:default" 
a[6]a[6]2default:default" 
a[5]a[5]2default:default" 
a[4]a[4]2default:default" 
b[7]b[7]2default:default" 
b[6]b[6]2default:default" 
b[5]b[5]2default:default" 
b[4]b[4]2default:default2default:default2(
 DRC|Pin Planning2default:default8ZUCIO-1h px� 
Z
DRC finished with %s
1905*	planAhead2
2 Errors2default:defaultZ12-3199h px� 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px� 
R
+Error(s) found during DRC. Bitgen not run.
1345*	planAheadZ12-1345h px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
92default:default2
02default:default2
02default:default2
32default:defaultZ4-41h px� 
Q

%s failed
30*	vivadotcl2#
write_bitstream2default:defaultZ4-43h px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Fri Feb 28 17:26:20 20252default:defaultZ17-206h px� 


End Record