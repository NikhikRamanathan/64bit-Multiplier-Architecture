# Final PPA Comparison

| Architecture | Cell Count | Area | Critical Path Delay | Fmax | Slack @ 10 ns | Internal Power | Switching Power | Leakage Power | Total Power |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Array | 58,143 | 281,337.32 | 82.41 ns | 12.13 MHz | -72.41 ns | 42.1 mW | 58.8 mW | 0.000125 mW | 101.0 mW |
| Radix-4 Booth | 37,939 | 195,945.43 | 15.91 ns | 62.85 MHz | -5.91 ns | 40.3 mW | 45.0 mW | 0.0000836 mW | 85.3 mW |
| Dadda | 38,802 | 211,853.18 | 6.66 ns | 150.15 MHz | +3.34 ns | 31.5 mW | 32.1 mW | 0.0000976 mW | 63.6 mW |

## Conclusion

The Dadda multiplier achieved the strongest overall power-performance-area trade-off among the evaluated architectures. Although the Booth multiplier used the lowest cell area, the Dadda multiplier achieved the shortest critical path delay, highest Fmax, positive timing slack at a 10 ns constraint, and the lowest activity-based power. The Array multiplier was structurally simple but showed the largest area, longest delay, and highest power consumption.
