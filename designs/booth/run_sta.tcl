read_liberty /home/nikhil/vlsi_project/PDK/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog synth_netlist.v

link_design booth_multiplier_64bit

create_clock -name vclk -period 10

set_input_delay 0 -clock vclk [all_inputs]
set_output_delay 0 -clock vclk [all_outputs]

report_checks -from [all_inputs] -to [all_outputs] -path_delay max
report_worst_slack -max