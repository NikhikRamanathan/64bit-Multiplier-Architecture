read_lef /path/to/sky130_fd_sc_hd_merged.lef
read_liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog designs/booth/synth_netlist.v
link_design booth_multiplier_64bit

create_clock -name vclk -period 10
read_vcd -scope testbench.uut results/vcd/booth_gate_power.vcd

report_power > results/power/booth_power_report.txt
exit
