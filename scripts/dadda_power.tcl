read_lef /path/to/sky130_fd_sc_hd_merged.lef
read_liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog designs/dadda/synth_netlist.v
link_design dadda_multiplier_64bit

create_clock -name vclk -period 10
read_vcd -scope testbench.uut results/vcd/dadda_gate_power.vcd

report_power > results/power/dadda_power_report.txt
exit
