read_lef /path/to/sky130_fd_sc_hd_merged.lef
read_liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog designs/array/synth_netlist.v
link_design array_multiplier_64bit

create_clock -name vclk -period 10
read_vcd -scope testbench.uut results/vcd/array_gate_power.vcd

report_power > results/power/array_power_report.txt
exit
