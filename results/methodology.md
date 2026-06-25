# Methodology

Each multiplier architecture was implemented in SystemVerilog and verified using directed and randomized simulation testbenches. RTL synthesis was performed using Yosys with SKY130 HD standard-cell liberty files. Timing analysis was performed using an open-source static timing analysis flow with a 10 ns virtual clock constraint.

Gate-level switching activity was generated through post-synthesis simulation, and activity-based power estimation was performed in OpenROAD using SKY130 HD LEF and Liberty files. The same functional verification approach and comparable stimulus conditions were used across Array, Radix-4 Booth, and Dadda multiplier architectures.

## Tools Used

- SystemVerilog
- Icarus Verilog
- Yosys
- ABC
- OpenSTA
- OpenROAD
- SKY130 HD standard-cell library
- macOS Terminal
- Ubuntu Linux
- AWS EC2 for OpenROAD execution

## Limitations

The reported power values are activity-dependent and based on the supplied simulation stimulus. The analysis is pre-layout and does not include final routed parasitics. Therefore, the results should be interpreted as comparative open-source ASIC flow estimates rather than final silicon signoff results.
